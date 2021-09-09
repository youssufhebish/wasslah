import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/modules/add_post/add_post.dart';
import 'package:social_media_application/shared/components/widgets/text_button.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class Layout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppCubit.get(context).title[AppCubit.get(context).currentIndex],
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ConditionalBuilder(
        condition: AppCubit.get(context).model != null,
        fallback: (context) => Center(child: CircularProgressIndicator(),),
        builder: (context){
          return AppCubit.get(context).screens[AppCubit.get(context).currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: AppCubit.get(context).currentIndex,
        onTap: (i) {
          AppCubit.get(context).indexChange(i);
        },
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Home),
            label: 'feeds'.toLowerCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Chat),
            label: 'Chat'.toLowerCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Notification),
            label: 'Notification'.toLowerCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Profile),
            label: 'profile'.toLowerCase(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(IconBroken.Plus),
        backgroundColor: kPrimaryColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()),);
        },
      ),
    );
  }
}
