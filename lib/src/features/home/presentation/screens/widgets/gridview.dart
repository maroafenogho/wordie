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

class NotesGridView extends StatelessWidget {
  const NotesGridView({
    super.key,
    required this.ref,
    required this.currentUser,
    required this.data,
    required this.size,
  });

  final WidgetRef ref;
  final AsyncValue<User?> currentUser;
  final List<Note> data;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          ref.read(selectedNoteProvider.notifier).state = data[index];

          context.goNamed(NoteDetailsScreen.routeName);
        },
        child: Container(
          padding: EdgeInsets.all(20),
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
                data[index].title,
                maxLines: 1,
                style: WordieTypography.h3,
              ),
              // Text(
              //   data[index].body,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: WordieTypography.bodyText16,
              // ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Last updated:\n${data[index].updated.dateFromString}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: WordieTypography.bodyText10,
                ),
              ),
              const Divider(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ref.read(selectedNoteProvider.notifier).state =
                              data[index];
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
                                    backgroundColor: WordieConstants.mainColor,
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
                                    backgroundColor: WordieConstants.mainColor,
                                  ));
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          bool success = await ref
                              .read(asyncUpdateFavProvider.notifier)
                              .updateFavNote(
                                  oldTitle: data[index].title,
                                  isFav: !data[index].isFavorite);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(data[index].isFavorite
                                  ? 'Removed to fovourites'
                                  : 'Added to fovourites'),
                              dismissDirection: DismissDirection.up,
                              backgroundColor: WordieConstants.mainColor,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(ref
                                  .watch(asyncUpdateProvider)
                                  .error
                                  .toString()),
                              dismissDirection: DismissDirection.up,
                              backgroundColor: WordieConstants.mainColor,
                            ));
                          }
                        },
                        child: Icon(data[index].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ref.read(selectedNoteProvider.notifier).state =
                              data[index];
                          context.goNamed(EditNoteScreen.routeName);
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
    );
  }
}
