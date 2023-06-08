// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';

class NoteDetailsScreen extends ConsumerWidget {
  const NoteDetailsScreen({super.key});
  static const routeName = 'note_details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNote = ref.watch(selectedNoteProvider);

    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selectedNote.title, style: WordieTypography.h1),
            20.0.vSpace,
            Text(selectedNote.body, style: WordieTypography.bodyText16),
            30.0.vSpace,
          ],
        ),
      ),
    );
  }
}
