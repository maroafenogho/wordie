// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/controllers/delete_note.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/controllers/update_note.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/delete_widget.dart';

class NoteDetailsScreen extends ConsumerWidget {
  NoteDetailsScreen({super.key});
  static const routeName = 'note_details';
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNote = ref.watch(selectedNoteProvider);
    Size size = MediaQuery.of(context).size;

    final currentUser = ref.watch(currentUserProvider);
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
            _focusNode.hasPrimaryFocus
                ? () {
                    _focusNode.unfocus();
                    _focusNode.dispose();
                  }
                : () {};
            checkNoteUpdate(
              ref: ref,
              selectedNote: selectedNote,
              currentUser: currentUser,
            );
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => DeleteBottomSheet(
                  size: size,
                  onNoTap: () => context.pop(),
                  onYesTap: () async {
                    bool success = await ref
                        .read(asyncDeleteNoteProvider.notifier)
                        .deleteNote(
                            userId: currentUser.value!.userId,
                            noteId: ref.watch(selectedNoteProvider).noteId);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Deleted'),
                        dismissDirection: DismissDirection.up,
                        backgroundColor: WordieConstants.mainColor,
                      ));
                      context.pop();
                      context.pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(ref
                            .watch(asyncDeleteNoteProvider)
                            .error
                            .toString()),
                        dismissDirection: DismissDirection.up,
                        backgroundColor: WordieConstants.mainColor,
                      ));
                      context.pop();
                    }
                  },
                  isLoading: ref.watch(asyncDeleteNoteProvider).isLoading,
                ),
              );
            },
            child: const Icon(Icons.delete),
          ),
          10.0.hSpace,
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.cancel_sharp),
          ),
          20.0.hSpace
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _focusNode.requestFocus();
        },
        tooltip: 'Edit Note',
        backgroundColor: WordieConstants.containerColor,
        foregroundColor: WordieConstants.mainColor,
        splashColor: WordieConstants.backgroundColor,
        child: const Icon(Icons.edit_note),
      ),
      body: BackButtonListener(
        onBackButtonPressed: () {
          _focusNode.dispose();

          checkNoteUpdate(
              ref: ref, selectedNote: selectedNote, currentUser: currentUser);
          return Future.delayed(const Duration(seconds: 0));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  style: WordieTypography.h1,
                  decoration: const InputDecoration(
                    hintText: 'Note body',
                  ),
                ),
              ),
              // Text(selectedNote.title, style: WordieTypography.h1),
              Expanded(
                flex: 9,
                child: TextField(
                  controller: bodyController,
                  focusNode: _focusNode,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: WordieTypography.bodyText16,
                  decoration: const InputDecoration(
                      hintText: 'Note body', border: InputBorder.none),
                ),
              ),
              // Text(selectedNote.body, style: WordieTypography.bodyText16),
              20.0.vSpace,
            ],
          ),
        ),
      ),
    );
  }

  checkNoteUpdate({required ref, required selectedNote, required currentUser}) {
    if ((titleController.text.isNotEmpty && bodyController.text.isNotEmpty) &&
        (titleController.text.trim() != selectedNote.title ||
            bodyController.text.trim() != selectedNote.body)) {
      ref.read(asyncUpdateProvider.notifier).updateNote(
          userId: ref.watch(currentUserProvider).value!.userId,
          noteId: selectedNote.noteId,
          newTitle: titleController.text.trim(),
          newBody: bodyController.text.trim());
    } else if (titleController.text.isEmpty && bodyController.text.isEmpty) {
      ref.read(asyncDeleteNoteProvider.notifier).deleteNote(
          userId: currentUser.value!.userId,
          noteId: ref.watch(selectedNoteProvider).noteId);
    }
  }
}
