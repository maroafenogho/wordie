import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';

extension AsyncValueUi on AsyncValue {
  void showErrorSnackBar(BuildContext context) {
    if (!isLoading && hasError) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        error.toString(),
                        style: WordieTypography.bodyText14,
                      ),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.containerColor,
                    ));
    }
  }
}
