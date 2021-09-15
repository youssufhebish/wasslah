import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/shared/components/widgets/post_element.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.posts.length > 0,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return postElement(
                  context: context,
                  userImage: cubit.model.image,
                  userName: cubit.model.name,
                  date: cubit.posts[index].dateTime,
                  postText: cubit.posts[index].text,
                  postImage: cubit.posts[index].postImage,
                  postId: cubit.postId[index],
                  likesNum: cubit.likes[index],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
              itemCount: cubit.posts.length,
            );
          },
        );
      },
    );
  }
}
