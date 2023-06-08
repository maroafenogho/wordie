import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/game/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/game/presentation/screens/add_note.dart';
import 'package:wordie/src/features/game/presentation/screens/edit_note.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final notesList = ref.watch(notesListProvider);
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 20),
        child: AppBar(
          backgroundColor: WordieConstants.backgroundColor,
        ),
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
              notesList.when(
                  data: (data) => ListView.separated(
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
                                data[index].title,
                                style: WordieTypography.h1,
                              ),
                              Text(
                                data[index].body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: WordieTypography.bodyText16,
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              oldTitle: data[index].title,
                                              isFav: !data[index].isFavorite);
                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(data[index].isFavorite
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
                                    child: Icon(data[index].isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ref
                                          .read(selectedNoteProvider.notifier)
                                          .state = data[index];
                                      context.goNamed(EditNoteScreen.routeName);
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ],
                              )
                            ],
                          )),
                      separatorBuilder: (context, index) => 10.0.vSpace,
                      itemCount: data.length),
                  error: (error, stackTrace) =>
                      const CircularProgressIndicator(),
                  loading: () => CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        backgroundColor: WordieConstants.mainColor,
        foregroundColor: WordieConstants.backgroundColor,
        splashColor: WordieConstants.backgroundColor,
        onPressed: () {
          context.goNamed(AddNoteScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
