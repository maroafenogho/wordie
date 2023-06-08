import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/game/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/game/presentation/screens/edit_note.dart';

class Favourites extends ConsumerWidget {
  const Favourites({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    final favNotesList = ref
        .watch(notesListProvider)
        .value!
        .where((note) => note.isFavorite)
        .toList();
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        title: const Center(
            child: Text(
          'Favourites',
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentUser.value!.fullName!,
                style: WordieTypography.bodyText12,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
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
                            favNotesList[index].title,
                            style: WordieTypography.h1,
                          ),
                          Text(
                            favNotesList[index].body,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: WordieTypography.bodyText16,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(Icons.delete),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool success = await ref
                                      .read(asyncUpdateFavProvider.notifier)
                                      .updateFavNote(
                                          oldTitle: favNotesList[index].title,
                                          isFav:
                                              !favNotesList[index].isFavorite);
                                  if (success) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          favNotesList[index].isFavorite
                                              ? 'Removed to fovourites'
                                              : 'Added to fovourites'),
                                      dismissDirection: DismissDirection.up,
                                      backgroundColor:
                                          WordieConstants.mainColor,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(ref
                                          .watch(asyncUpdateProvider)
                                          .error
                                          .toString()),
                                      dismissDirection: DismissDirection.up,
                                      backgroundColor:
                                          WordieConstants.mainColor,
                                    ));
                                  }
                                },
                                child: Icon(favNotesList[index].isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                              ),
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(selectedNoteProvider.notifier)
                                      .state = favNotesList[index];
                                  context.goNamed(EditNoteScreen.routeName);
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          )
                        ],
                      )),
                  separatorBuilder: (context, index) => 10.0.vSpace,
                  itemCount: favNotesList.length),
            ],
          ),
        ),
      ),
    );
  }
}
