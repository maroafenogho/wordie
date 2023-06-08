import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';

class WordieButton extends StatelessWidget {
  const WordieButton({
    super.key,
    required this.isLoading,
    required this.text,
    required this.onPressed,
  });

  final bool isLoading;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: WordieConstants.backgroundColor,
            backgroundColor: WordieConstants.mainColor),
        child: isLoading
            ? const CircularProgressIndicator(
                color: WordieConstants.backgroundColor)
            : Text(
                text.toUpperCase(),
                style: WordieTypography.h5
                    .copyWith(color: WordieConstants.backgroundColor),
              ),
      ),
    );
  }
}
