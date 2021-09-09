import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/modules/edit_profile/edit_profile.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var c = AppCubit.get(context).model;
    var a = AppCubit.get(context);
    
    return ConditionalBuilder(
      condition: a.state is! GetUserDataInitialState,
      builder: (context) {
      return Column(
        children: [
          Container(
            height: 180.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: a.coverImage == null? NetworkImage(c.coverImage) : FileImage(a.coverImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0),),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Stack(
                    alignment: Alignment.center ,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 53.0,
                          backgroundColor: kPrimaryColor,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor,
                                offset: Offset(0.0, -2.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: a.profileImage == null? NetworkImage(c.image) : FileImage(a.profileImage),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0,),
          Text(c.name,
            style: Theme.of(context).textTheme.bodyText1,),
          Text(
            c.bio,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 5.0,),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('100', style: Theme.of(context).textTheme.bodyText1,),
                        Text('posts'.toUpperCase(), style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('100', style: Theme.of(context).textTheme.bodyText1,),
                        Text('posts'.toUpperCase(), style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('100', style: Theme.of(context).textTheme.bodyText1,),
                        Text('posts'.toUpperCase(), style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('100', style: Theme.of(context).textTheme.bodyText1,),
                        Text('posts'.toUpperCase(), style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      )),
                ),
                SizedBox(width: 5.0,),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                  },
                  child: Icon(
                    IconBroken.Edit,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}
