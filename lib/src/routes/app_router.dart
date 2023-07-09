import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/auth/presentation/screens/forgot_password.dart';
import 'package:wordie/src/features/auth/presentation/screens/login_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/wrapper.dart';
import 'package:wordie/src/features/notes/presentation/screens/account.dart';
import 'package:wordie/src/features/home/presentation/screens/add_note.dart';
import 'package:wordie/src/features/home/presentation/screens/edit_note.dart';
import 'package:wordie/src/features/home/presentation/screens/home.dart';
import 'package:wordie/src/features/notes/presentation/screens/fav.dart';
import 'package:wordie/src/features/notes/presentation/screens/notes_dash.dart';
import 'package:wordie/src/features/onboarding/presentation/screens/splashscreen.dart';
import 'package:wordie/src/routes/scaffold_with_nav_bar.dart';

import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/notes/domain/user_note.dart';
import '../features/notes/presentation/screens/add_note.dart';
import '../features/notes/presentation/screens/note_details_screen.dart';
import 'go_router_refresh_stream.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  splashscreen,
  signUp,
  signIn,
  resetPassword,
  notes,
  favNotes,
  account,
  addNote,
  noteDetails,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  final currentUser = ref.watch(currentUserProvider);
  return GoRouter(
      initialLocation: '/splashscreen',
      navigatorKey: _rootNavigatorKey,
      refreshListenable: GoRouterRefreshStream(authRepo.currentUser),
      redirect: (context, state) {
        log('PATH:: ${state.location}');
        final isLoggedIn = currentUser.value != null;
        if (isLoggedIn) {
          if (state.location.contains('signin')) {
            return '/notes';
          }
        } else {
          if (state.location.contains('account')) {
            return '/signin';
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: AppRoute.splashscreen.name,
          path: '/splashscreen',
          builder: (context, state) =>
              Splashscreen(loggedIn: currentUser.value != null),
        ),
        GoRoute(
          name: AppRoute.signUp.name,
          path: '/signup',
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
            name: AppRoute.signIn.name,
            path: '/signin',
            builder: (context, state) => LoginScreen(),
            routes: [
              GoRoute(
                name: AppRoute.resetPassword.name,
                path: 'resetpassword',
                builder: (context, state) => ResetPasswordScreen(),
              ),
            ]),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return ScaffoldWithBottomNavBar(child: child);
            },
            routes: [
              GoRoute(
                  path: '/notes',
                  name: AppRoute.notes.name,
                  pageBuilder: (context, state) => MaterialPage(
                        key: state.pageKey,
                        child: const NotesHome(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'addnote',
                      name: AppRoute.addNote.name,
                      builder: (context, state) => const AddNewNote(),
                    ),
                    GoRoute(
                        path: ':noteId',
                        name: AppRoute.noteDetails.name,
                        builder: (context, state) {
                          final note = state.extra as Note;
                          return NoteDetailsScreen(
                            note: note,
                          );
                        })
                  ]),
              GoRoute(
                path: '/favorites',
                name: AppRoute.favNotes.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const FavoritesScreen(),
                ),
              ),
              GoRoute(
                path: '/account',
                name: AppRoute.account.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const AccountScreen(),
                ),
              ),
            ]),
        GoRoute(
            name: HomeScreen.routeName,
            path: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: AddNoteScreen.routeName,
                name: AddNoteScreen.routeName,
                builder: (context, state) => AddNoteScreen(),
              ),
              GoRoute(
                path: EditNoteScreen.routeName,
                name: EditNoteScreen.routeName,
                builder: (context, state) => EditNoteScreen(),
              ),
            ]),
        GoRoute(
          name: Wrapper.routeName,
          path: Wrapper.routeName,
          builder: (context, state) => const Wrapper(),
        ),
      ]);
});
