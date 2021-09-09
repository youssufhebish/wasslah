import 'package:flutter/material.dart';
import 'package:social_media_application/modules/sign_up_screen/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
