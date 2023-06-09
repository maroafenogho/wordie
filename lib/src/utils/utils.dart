import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';

showSnackbar(String text, context){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        text,
                        style: WordieTypography.bodyText14,
                      ),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.containerColor,
                    ));
}