import 'package:flutter/material.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class AddPostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var c = AppCubit.get(context).model;
    var a = AppCubit.get(context);
    TextEditingController postController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('add post'.toUpperCase(),
        style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: (){
              if(a.postImage == null){
                a.createPost(dateTime: DateTime.now().toString(), text: postController.text);
              } else {
                a.uploadPostImage(dateTime: DateTime.now().toString(), text: postController.text,);
              }
              a.posts = [];
              a.getPosts();
            },
            child: Text(
              'post'.toUpperCase(),
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            if(a.state is CreatePostLoadingState)
              LinearProgressIndicator(),
            if(a.state is CreatePostLoadingState)
              SizedBox(height: 5.0,),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(c.image),
                  radius: 25.0,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(a.model.name),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                    Text(
                      'public'.toUpperCase(),
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 10.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: TextField(
                  controller: postController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 25,
                  decoration: InputDecoration(
                    hintText: 'What\'s your mind, ${c.name.split(' ')[0]}',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            if(a.postImage != null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0,),
                      image: DecorationImage(
                        image: FileImage(a.postImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 20.0,
                      child: Icon(
                        Icons.close,
                        size: 16.0,
                      ),
                    ),
                    onPressed: ()
                    {
                      a.removePostImage();
                    },
                  ),
                ],
              ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 125.0,
              alignment: Alignment.center,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconBroken.Upload,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Add Photo',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
                onPressed: (){
                  a.getPostImage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
