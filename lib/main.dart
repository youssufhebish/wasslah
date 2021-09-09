import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/layout/layout.dart';
import 'package:social_media_application/modules/log_in_screen/login_screen.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await Firebase.initializeApp();

  uId = CacheHelper.getData(key: 'uId') ?? "";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getUserData()..getPosts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wasslah'.toUpperCase(),
            theme: ThemeData(
              fontFamily: 'Montserrat',
              primaryColor: kPrimaryColor,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0.0,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: uId == ""? LoginScreen() : Layout(),
          );
        },
      ),
    );
  }
}
