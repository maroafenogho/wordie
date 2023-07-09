import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/gridview.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/listview.dart';
import 'package:wordie/src/features/settings/presentation/controllers/settings_controller.dart';

import '../controllers/fav_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Consumer(
        builder: (context, ref, child) {
          final currentUser = ref.watch(currentUserProvider);
          final displayType = ref.watch(displayTypeProvider);
          final notesList = ref.watch(asyncFavNotesStream);
          Size size = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notesList.when(
                    data: (data) => data.isEmpty
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
                                    'You do not have any notes.\nTap on the button below to add a note.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : displayType == 'list'
                            ? NotesListView(
                                ref: ref,
                                currentUser: currentUser,
                                notesList: data.orderedByDate,
                                size: size,
                              )
                            : NotesGridView(
                                ref: ref,
                                currentUser: currentUser,
                                notesList: data.orderedByDate,
                                size: size),
                    error: (error, stackTrace) =>
                        const CircularProgressIndicator(),
                    loading: () => const LinearProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).darkStatusBar();
  }
}
