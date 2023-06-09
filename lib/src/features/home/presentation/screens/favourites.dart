import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/gridview.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/listview.dart';
import 'package:wordie/src/features/settings/presentation/controllers/settings_controller.dart';

class Favourites extends ConsumerWidget {
  const Favourites({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    Size size = MediaQuery.of(context).size;
    final displayType = ref.watch(displayTypeProvider);

    final favNotesList = ref
        .watch(notesListProvider)
        .value
        ?.where((note) => note.isFavorite)
        .toList();
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        title: const Center(
            child: Text(
          'Favourites',
          style: WordieTypography.h2,
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (favNotesList != null && favNotesList.isEmpty)
                  ? SizedBox(
                      height: size.height * 0.7,
                      width: size.width,
                      child: const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_add,
                            size: 50,
                            color: WordieConstants.containerColor,
                          ),
                          Text(
                            'You do not have any favourite notes.\nTap on the heart icon on the dashboard if you want to add a note.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )))
                  : displayType == 'list'
                      ? NotesListView(
                          ref: ref,
                          currentUser: currentUser,
                          notesList: favNotesList!,
                          size: size)
                      : NotesGridView(
                          ref: ref,
                          currentUser: currentUser,
                          notesList: favNotesList!,
                          size: size)
            ],
          ),
        ),
      ),
    );
  }
}
