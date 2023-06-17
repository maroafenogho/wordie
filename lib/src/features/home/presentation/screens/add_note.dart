// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/controllers/create_note.dart';

class AddNoteScreen extends ConsumerWidget {
  AddNoteScreen({super.key});
  static const routeName = 'add_note';
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            }
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.cancel_sharp),
          ),
          20.0.hSpace
        ],
        title: const Text(
          'Add Note',
          style: WordieTypography.h4,
        ),
      ),
      body: BackButtonListener(
        onBackButtonPressed: () async {
          context.pop();
          if (titleController.text.isNotEmpty &&
              bodyController.text.isNotEmpty) {
            ref.read(asyncAddNoteProvider.notifier).createNote(
                userId: ref.watch(currentUserProvider).value!.userId,
                noteTitle: titleController.text.trim(),
                noteBody: bodyController.text.trim());
          }
          return Future.delayed(const Duration(seconds: 0));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              30.0.vSpace,
              Expanded(
                flex: 1,
                child: TextField(
                  controller: titleController,
                  style: WordieTypography.h1,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(hintText: 'Note Title'),
                ),
              ),
              10.0.vSpace,
              Expanded(
                flex: 9,
                child: TextField(
                  controller: bodyController,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  autofocus: true,
                  expands: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: WordieTypography.bodyText16,
                  decoration: const InputDecoration(
                      hintText: 'Note body', border: InputBorder.none),
                ),
              ),
              30.0.vSpace,
            ],
          ),
        ),
      ),
    ).darkStatusBar();
  }
}
