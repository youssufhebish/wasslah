import 'package:flutter/material.dart';
import 'package:social_media_application/modules/log_in_screen/component/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
