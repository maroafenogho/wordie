// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/home/presentation/controllers/update_fav_note.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';
import 'package:wordie/src/routes/app_router.dart';
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
          // ref.read(selectedNoteProvider.notifier).state = notesList[index];

          context.goNamed(
            AppRoute.noteDetails.name,
            pathParameters: {'noteId': notesList[index].noteId},
            extra: notesList[index],
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          decoration: BoxDecoration(
              color: WordieConstants.containerColor,
              borderRadius: BorderRadius.only(
                bottomRight: 30.0.cRadius,
                topLeft: 30.0.cRadius,
              )),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notesList[index].title,
                    maxLines: 2,
                    softWrap: true,
                    style: WordieTypography.h4,
                  ),
                  10.0.vSpace,
                  Text(
                    'Last updated:\n${notesList[index].updated.dateFromString}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: WordieTypography.bodyText10,
                  ),
                ],
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: InkWell(
                  onTap: () async {
                    bool success = await ref
                        .read(asyncUpdateFavProvider.notifier)
                        .updateFavNote(
                            noteId: notesList[index].noteId,
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
        ).animate().fadeIn(),
      ),
      itemCount: notesList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
    );
  }
}
