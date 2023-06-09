// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/home/domain/note.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/screens/edit_note.dart';
import 'package:wordie/src/features/home/presentation/screens/note_details.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/delete_widget.dart';
import 'package:wordie/src/utils/utils.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.ref,
    required this.currentUser,
    required this.notesList,
    required this.size,
  });

  final WidgetRef ref;
  final AsyncValue<User?> currentUser;
  final List<Note> notesList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          ref.read(selectedNoteProvider.notifier).state = notesList[index];

          context.goNamed(NoteDetailsScreen.routeName);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: WordieConstants.containerColor,
              borderRadius: BorderRadius.only(
                bottomRight: 30.0.cRadius,
                topLeft: 30.0.cRadius,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notesList[index].title,
                style: WordieTypography.h1,
              ),
              Text(
                notesList[index].body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: WordieTypography.bodyText16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Last updated: ${notesList[index].updated.dateFromString}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: WordieTypography.bodyText12,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ref.read(selectedNoteProvider.notifier).state =
                          notesList[index];
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
                                    oldTitle:
                                        ref.watch(selectedNoteProvider).title);
                            if (success) {
                              showSnackbar('Delted', context);

                              context.pop();
                            } else {
                              showSnackbar(
                                  ref
                                      .watch(asyncDeleteNoteProvider)
                                      .error
                                      .toString(),
                                  context);

                              context.pop();
                            }
                          },
                          isLoading:
                              ref.watch(asyncDeleteNoteProvider).isLoading,
                        ),
                      );
                    },
                    child: Icon(Icons.delete),
                  ),
                  InkWell(
                    onTap: () async {
                      bool success = await ref
                          .read(asyncUpdateFavProvider.notifier)
                          .updateFavNote(
                              oldTitle: notesList[index].title,
                              isFav: !notesList[index].isFavorite);
                      if (success) {
                        showSnackbar(
                            notesList[index].isFavorite
                                ? 'Removed to fovourites'
                                : 'Added to fovourites',
                            context);
                      } else {
                        showSnackbar(
                            ref.watch(asyncUpdateFavProvider).error.toString(),
                            context);
                      }
                    },
                    child: Icon(notesList[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(selectedNoteProvider.notifier).state =
                          notesList[index];
                      context.goNamed(EditNoteScreen.routeName);
                    },
                    child: Icon(Icons.edit),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => 10.0.vSpace,
      itemCount: notesList.length,
    ).animate().shimmer();
  }
}
