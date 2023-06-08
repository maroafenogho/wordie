import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/game/presentation/screens/add_note.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 20),
        child: AppBar(
          backgroundColor: WordieConstants.backgroundColor,
        ),
      ),
      body: Column(
        children: [
          Text(
            currentUser.value!.fullName!,
            style: WordieTypography.bodyText12,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        backgroundColor: WordieConstants.mainColor,
        foregroundColor: WordieConstants.backgroundColor,
        splashColor: WordieConstants.backgroundColor,
        onPressed: () {
          context.goNamed(AddNoteScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
