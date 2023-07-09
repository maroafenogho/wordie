import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/home/presentation/screens/widgets/delete_widget.dart';

import '../../domain/user_note.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key, required this.note});
  final Note note;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final _focusNode = FocusNode();
  bool showSaveButton = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    bodyController.text = widget.note.body;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: InkWell(
          onTap: () {
            context.pop();
            _focusNode.hasPrimaryFocus
                ? () {
                    _focusNode.unfocus();
                    _focusNode.dispose();
                  }
                : () {};
            // checkNoteUpdate(
            //   ref: ref,
            //   selectedNote: selectedNote,
            //   currentUser: currentUser,
            // );
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Visibility(
            visible: showSaveButton,
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => DeleteBottomSheet(
                  size: size,
                  onNoTap: () => context.pop(),
                  onYesTap: () async {},
                  isLoading: false,
                ),
              );
            },
            child: const Icon(Icons.delete),
          ),
          10.0.hSpace,
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.cancel_sharp),
          ),
          20.0.hSpace
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _focusNode.requestFocus();
        },
        tooltip: 'Edit Note',
        backgroundColor: WordieConstants.containerColor,
        foregroundColor: WordieConstants.mainColor,
        splashColor: WordieConstants.backgroundColor,
        child: const Icon(Icons.edit_note),
      ),
      body: BackButtonListener(
        onBackButtonPressed: () {
          _focusNode.dispose();

          return Future.delayed(const Duration(seconds: 0));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  style: WordieTypography.h1,
                  onChanged: (value) {
                    if (value != widget.note.title ||
                        bodyController.text != widget.note.body) {
                      if (!showSaveButton) {
                        setState(() {
                          showSaveButton = true;
                        });
                      }
                    } else {
                      if (showSaveButton) {
                        setState(() {
                          showSaveButton = false;
                        });
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Note body',
                  ),
                ),
              ),
              // Text(selectedNote.title, style: WordieTypography.h1),
              Expanded(
                flex: 9,
                child: TextField(
                  controller: bodyController,
                  focusNode: _focusNode,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  onChanged: (value) {
                    if (value != widget.note.body ||
                        titleController.text != widget.note.title) {
                      if (!showSaveButton) {
                        setState(() {
                          showSaveButton = true;
                        });
                      }
                    } else {
                      if (showSaveButton) {
                        setState(() {
                          showSaveButton = false;
                        });
                      }
                    }
                  },
                  expands: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: WordieTypography.bodyText16,
                  decoration: const InputDecoration(
                      hintText: 'Start typing...', border: InputBorder.none),
                ),
              ),
              // Text(selectedNote.body, style: WordieTypography.bodyText16),
              20.0.vSpace,
            ],
          ),
        ),
      ),
    );
  }
}
