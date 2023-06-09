// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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

class NotesGridView extends StatelessWidget {
  const NotesGridView({
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          ref.read(selectedNoteProvider.notifier).state = notesList[index];

          context.goNamed(NoteDetailsScreen.routeName);
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: WordieConstants.containerColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: 30.0.cRadius,
                    topLeft: 30.0.cRadius,
                  )),
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      notesList[index].title,
                      maxLines: 2,
                      softWrap: true,
                      style: WordieTypography.h1,
                    ),
                  ),
                  // Text(
                  //   data[index].body,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: WordieTypography.bodyText16,
                  // ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Last updated:\n${notesList[index].updated.dateFromString}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: WordieTypography.bodyText10,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
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
                                            oldTitle: ref
                                                .watch(selectedNoteProvider)
                                                .title);
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Deleted'),
                                        dismissDirection: DismissDirection.up,
                                        backgroundColor:
                                            WordieConstants.mainColor,
                                      ));
                                      context.pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(ref
                                            .watch(asyncDeleteNoteProvider)
                                            .error
                                            .toString()),
                                        dismissDirection: DismissDirection.up,
                                        backgroundColor:
                                            WordieConstants.mainColor,
                                      ));
                                      context.pop();
                                    }
                                  },
                                  isLoading: ref
                                      .watch(asyncDeleteNoteProvider)
                                      .isLoading,
                                ),
                              );
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.delete)),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ref.read(selectedNoteProvider.notifier).state =
                                  notesList[index];
                              context.goNamed(EditNoteScreen.routeName);
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.edit)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
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
                child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all()),
                  child: Icon(
                    notesList[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      itemCount: notesList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
    );
  }
}
