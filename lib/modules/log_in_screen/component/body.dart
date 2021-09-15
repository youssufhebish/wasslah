import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_application/layout/layout.dart';
import 'package:social_media_application/modules/log_in_screen/component/background.dart';

import 'package:social_media_application/modules/sign_up_screen/signup_screen.dart';
import 'package:social_media_application/shared/components/widgets/already_have_an_account_acheck.dart';
import 'package:social_media_application/shared/components/widgets/rounded_button.dart';
import 'package:social_media_application/shared/components/widgets/rounded_input_field.dart';
import 'package:social_media_application/shared/components/widgets/rounded_password_field.dart';

import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';

class Body extends StatelessWidget {

  TextEditingController email =  TextEditingController();
  TextEditingController name =  TextEditingController();
  TextEditingController phone =  TextEditingController();
  TextEditingController password =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is LogInDoneState)
          {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('login successfully done'),
                backgroundColor: Colors.green,
              )
            );
            print('login success');
            AppCubit.get(context).getUserData();
            AppCubit.get(context).getPosts();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Layout(),
              ),
            );
          } else if(state is LogInErrorState){
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppCubit.get(context).e),
                  backgroundColor: Colors.red,
                )
            );
          }
        },
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.30,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: email,
                    hintText: "Your Email",
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    password: password,
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      AppCubit.get(context).userLogIn(
                        name: name.text,
                        email: email.text,
                        password: password.text,
                        phone: phone.text,
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}