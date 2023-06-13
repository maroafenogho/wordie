import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({
    super.key,
    required this.size,
    required this.onNoTap,
    required this.onYesTap,
    required this.isLoading,
  });

  final Size size;
  final Function() onNoTap;
  final bool isLoading;
  final Function() onYesTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: WordieConstants.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: 30.0.cRadius,
            topLeft: 30.0.cRadius,
          )),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Are you sure you want to delete this note?',
            style: WordieTypography.h4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: onNoTap,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20)),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: WordieConstants.mainColor,
                            strokeWidth: 2.0,
                          )
                        : const Text(
                            'No',
                            style: WordieTypography.h5,
                          ),
                  ),
                ),
              ),
              10.0.hSpace,
              Expanded(
                child: InkWell(
                  onTap: onYesTap,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: WordieConstants.mainColor,
                            strokeWidth: 2.0,
                          )
                        : Text(
                            'Yes',
                            style:
                                WordieTypography.h5.copyWith(color: Colors.red),
                          ),
                  ),
                ),
              ),
            ],
          ),
          10.0.vSpace
        ],
      ),
    );
  }
}
