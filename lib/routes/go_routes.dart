import 'package:go_router/go_router.dart';
import 'package:wordie/src/features/auth/presentation/screens/forgot_password.dart';
import 'package:wordie/src/features/auth/presentation/screens/login_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/wrapper.dart';
import 'package:wordie/src/features/home/presentation/screens/add_note.dart';
import 'package:wordie/src/features/home/presentation/screens/edit_note.dart';
import 'package:wordie/src/features/home/presentation/screens/home.dart';
import 'package:wordie/src/features/home/presentation/screens/note_details.dart';
import 'package:wordie/src/features/onboarding/presentation/screens/splashscreen.dart';

final GoRouter routes =
    GoRouter(initialLocation: Splashscreen.routeName, routes: [
  GoRoute(
    name: 'Splashscreen',
    path: Splashscreen.routeName,
    builder: (context, state) => const Splashscreen(),
  ),
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeName,
    builder: (context, state) => SignUpScreen(),
  ),
  GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeName,
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          name: ResetPasswordScreen.routeName,
          path: ResetPasswordScreen.routeName,
          builder: (context, state) => ResetPasswordScreen(),
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
        GoRoute(
          path: NoteDetailsScreen.routeName,
          name: NoteDetailsScreen.routeName,
          builder: (context, state) => NoteDetailsScreen(),
        )
      ]),
  GoRoute(
    name: Wrapper.routeName,
    path: Wrapper.routeName,
    builder: (context, state) => const Wrapper(),
  ),
]);
