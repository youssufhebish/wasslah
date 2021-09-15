
import 'package:flutter/material.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

import 'package:social_media_application/shared/constants.dart';


Widget postElement({
  @required BuildContext context,
  @required String userImage,
  @required String userName,
  @required String date,
  @required String postText,
  @required String postImage,
  @required String postId,
  @required int likesNum,
}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 1.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage,),
                radius: 25.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(userName),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(IconBroken.Star,
                          color: kPrimaryColor,
                          size: 14.0,)
                      ],
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 10.0,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(icon: Icon(IconBroken.More_Circle, color: Colors.grey,), onPressed: (){}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Divider(),
          ),
          Text(
            postText,
            style: Theme.of(context).textTheme.caption.copyWith(
              height: 1,
              color: Colors.black,
            ),
          ),
          if(postImage != "")
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage(postImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if(postImage == '')
            SizedBox(height: 5.0,),
          Divider(),
          Row(
            children: [
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(likesNum.toString(),
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text('2500 Comments',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userImage,),
                    radius: 15.0,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      alignment: Alignment.centerLeft,
                      height: 30.0,
                      child: Text(
                        'leave a comment ...',
                        style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  AppCubit.get(context).likePost(postId);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0,),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text('like',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 10.0,),
              // InkWell(
              //   onTap: (){},
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0,),
              //     child: Row(
              //       children: [
              //         Icon(
              //           IconBroken.Send,
              //           color: Colors.green,
              //           size: 16.0,
              //         ),
              //         SizedBox(
              //           width: 3.0,
              //         ),
              //         Text('share',
              //           style: Theme.of(context).textTheme.caption,),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}