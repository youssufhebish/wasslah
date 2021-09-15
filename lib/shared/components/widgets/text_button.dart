
import 'package:flutter/material.dart';

import 'package:social_media_application/shared/constants.dart';

Widget defaultTextButton({
  @required Function onPressed,
  @required String text,
}) => TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: kPrimaryColor),
      ),
    );