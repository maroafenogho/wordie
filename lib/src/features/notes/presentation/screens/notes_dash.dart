import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/gridview.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/listview.dart';
import 'package:wordie/src/features/notes/presentation/controllers/notes_controller.dart';
import 'package:wordie/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:wordie/src/routes/app_router.dart';

class NotesHome extends StatelessWidget {
  const NotesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 20),
        child: AppBar(
          backgroundColor: WordieConstants.backgroundColor,
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final currentUser = ref.watch(currentUserProvider);
          final displayType = ref.watch(displayTypeProvider);
          final notesList = ref.watch(asyncNotesStream);
          Size size = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.0.vSpace,
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              bool success = await ref
                                  .read(updateDisplayTypeProvider.notifier)
                                  .setDisplayType('list');
                              if (success) {
                                ref.read(displayTypeProvider.notifier).state =
                                    'list';
                              }
                            },
                            child: Icon(
                              Icons.list,
                              color: displayType == 'list'
                                  ? WordieConstants.mainColor
                                  : WordieConstants.containerColor,
                            ),
                          ),
                          10.0.hSpace,
                          InkWell(
                            onTap: () async {
                              bool success = await ref
                                  .read(updateDisplayTypeProvider.notifier)
                                  .setDisplayType('grid');
                              if (success) {
                                ref.read(displayTypeProvider.notifier).state =
                                    'grid';
                              }
                            },
                            child: Icon(
                              Icons.grid_view_rounded,
                              color: displayType == 'grid'
                                  ? WordieConstants.mainColor
                                  : WordieConstants.containerColor,
                              size: 20,
                            ),
                          ),
                        ],
                      )),
                  Text.rich(
                    TextSpan(
                        text: DateTime.now().greeting,
                        style: WordieTypography.h3,
                        children: [
                          TextSpan(
                              text: currentUser.value == null
                                  ? ''
                                  : ' ${currentUser.value?.fullName?.firstName}',
                              style: WordieTypography.bodyText16)
                        ]),
                  ),
                  15.0.vSpace,
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
                    error: (error, stackTrace) {
                      debugPrint(stackTrace.toString());
                      return SizedBox(
                        height: size.height * 0.7,
                        width: size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.note_add,
                                size: 50,
                                color: WordieConstants.containerColor,
                              ),
                              const Text(
                                'You do not have any notes.\nTap on the button below to add a note.',
                                textAlign: TextAlign.center,
                              ),
                              ElevatedButton(
                                  onPressed: () => ref
                                      .watch(asyncNotesStream.notifier)
                                      .getNotesStream(),
                                  child: Text('Reload'))
                            ],
                          ),
                        ),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        tooltip: 'Add Note',
        backgroundColor: WordieConstants.containerColor,
        foregroundColor: WordieConstants.mainColor,
        splashColor: WordieConstants.backgroundColor,
        onPressed: () {
          context.goNamed(AppRoute.addNote.name);
        },
        child: const Icon(Icons.add),
      ),
    ).darkStatusBar();
  }
}
