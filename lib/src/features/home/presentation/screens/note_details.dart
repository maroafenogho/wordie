// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/delete_widget.dart';

class NoteDetailsScreen extends ConsumerWidget {
  NoteDetailsScreen({super.key});
  static const routeName = 'note_details';
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

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
            if (titleController.text.isNotEmpty &&
                bodyController.text.isNotEmpty) {
              ref.read(asyncAddNoteProvider.notifier).createNote(
                  userId: ref.watch(currentUserProvider).value!.userId,
                  noteTitle: titleController.text.trim(),
                  noteBody: bodyController.text.trim());
            } else {
              ref.read(asyncDeleteNoteProvider.notifier).deleteNote(
                  userId: currentUser.value!.userId,
                  oldTitle: ref.watch(selectedNoteProvider).title);
            }
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
                            oldTitle: ref.watch(selectedNoteProvider).title);
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
      body: BackButtonListener(
        onBackButtonPressed: () {
          if (titleController.text.isNotEmpty &&
              bodyController.text.isNotEmpty) {
            ref.read(asyncAddNoteProvider.notifier).createNote(
                userId: currentUser.value!.userId,
                noteTitle: titleController.text.trim(),
                noteBody: bodyController.text.trim());
          }
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
}
