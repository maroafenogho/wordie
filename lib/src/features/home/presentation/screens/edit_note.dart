// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/app_widgets/wordie_elevated_button.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/controllers/update_note.dart';

class EditNoteScreen extends ConsumerWidget {
  EditNoteScreen({super.key});
  static const routeName = 'edit_note';
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNote = ref.watch(selectedNoteProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      titleController.text = selectedNote.title;
      bodyController.text = selectedNote.body;
    });
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Edit Note',
          style: WordieTypography.h4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            30.0.vSpace,
            TextField(
              controller: titleController,
              style: WordieTypography.h1,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Note Title'),
            ),
            10.0.vSpace,
            TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              style: WordieTypography.bodyText16,
              decoration: const InputDecoration(hintText: 'Note body'),
            ),
            30.0.vSpace,
            WordieButton(
              isLoading: ref.watch(asyncUpdateProvider).isLoading,
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {
                  bool success = await ref
                      .read(asyncUpdateProvider.notifier)
                      .updateNote(
                          userId: ref.watch(currentUserProvider).value!.userId,
                          oldTitle: selectedNote.title,
                          newTitle: titleController.text.trim(),
                          newBody: bodyController.text.trim());

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Note updated successfully'),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.mainColor,
                    ));
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(ref.watch(asyncUpdateProvider).error.toString()),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.mainColor,
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Enter title and body to update note'),
                    dismissDirection: DismissDirection.up,
                    backgroundColor: WordieConstants.mainColor,
                  ));
                }
              },
              text: 'save',
            )
          ],
        ),
      ),
    );
  }
}
