// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/screens/add_note.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/gridview.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/listview.dart';
import 'package:wordie/src/features/settings/presentation/controllers/settings_controller.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final displayType = ref.watch(displayTypeProvider);
    final notesList = ref.watch(notesListProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 20),
        child: AppBar(
          backgroundColor: WordieConstants.backgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.0.vSpace,
              Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  onSelected: (value) async {
                    log(value);
                    bool success = await ref
                        .read(updateDisplayTypeProvider.notifier)
                        .setDisplayType(value);
                    if (success) {
                      ref.read(displayTypeProvider.notifier).state = value;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Display type updated to $value'),
                        dismissDirection: DismissDirection.up,
                        backgroundColor: WordieConstants.mainColor,
                      ));
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return const [
                      PopupMenuItem(
                        value: 'list',
                        child: Text('List'),
                      ),
                      PopupMenuItem(
                        value: 'grid',
                        child: Text('Grid'),
                      ),
                    ];
                  },
                ),
              ),
              Text.rich(
                TextSpan(
                    text: DateTime.now().greeting,
                    style: WordieTypography.h3,
                    children: [
                      TextSpan(
                          text: ' ${currentUser.value!.fullName!.firstName}',
                          style: WordieTypography.bodyText16)
                    ]),
              ),
              15.0.vSpace,
              notesList.when(
                data: (data) => data.isEmpty
                    ? SizedBox(
                        height: size.height * 0.7,
                        width: size.width,
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note_add,
                              size: 50,
                              color: WordieConstants.containerColor,
                            ),
                            Text(
                              'You do not have any notes.\nTap on the button below to add a note.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )))
                    : displayType == 'list'
                        ? NotesListView(
                            ref: ref,
                            currentUser: currentUser,
                            data: data,
                            size: size)
                        : NotesGridView(
                            ref: ref,
                            currentUser: currentUser,
                            data: data,
                            size: size),
                error: (error, stackTrace) => const CircularProgressIndicator(),
                loading: () => CircularProgressIndicator(),
              ),
            ],
          ),
        ),
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
