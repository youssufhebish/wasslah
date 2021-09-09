import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/modules/log_in_screen/login_screen.dart';
import 'package:social_media_application/modules/sign_up_screen/components/background.dart';
import 'package:social_media_application/modules/sign_up_screen/components/social_icon.dart';
import 'package:social_media_application/shared/components/widgets/already_have_an_account_acheck.dart';
import 'package:social_media_application/shared/components/widgets/rounded_button.dart';
import 'package:social_media_application/shared/components/widgets/rounded_input_field.dart';
import 'package:social_media_application/shared/components/widgets/rounded_password_field.dart';

import 'or_divider.dart';

class Body extends StatelessWidget {
  TextEditingController email =  TextEditingController();
  TextEditingController name =  TextEditingController();
  TextEditingController phone =  TextEditingController();
  TextEditingController password =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => null,
        builder: (context, state) {
          return Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: name,
                  hintText: "Your Name",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: email,
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  password: password,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: phone,
                  hintText: "Your Phone",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    AppCubit.get(context).userRegister(
                      name: name.text,
                      email: email.text,
                      password: password.text,
                      phone: phone.text,
                    );
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
