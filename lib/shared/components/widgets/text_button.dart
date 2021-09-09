
import 'package:flutter/material.dart';

import '../../constants.dart';

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