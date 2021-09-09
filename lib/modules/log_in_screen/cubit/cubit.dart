

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/modules/log_in_screen/cubit/state.dart';
import 'package:social_media_application/shared/network/local/cache_helper.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit() : super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  void userLogIn({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(LogInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user);
      CacheHelper.saveData(key: 'uId', value: value.user.uid);
      emit(LogInDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(LogInErrorState());
    });
  }
}