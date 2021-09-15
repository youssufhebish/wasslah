import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/modules/chat_details/chat_details.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var a = AppCubit.get(context);
        return ConditionalBuilder(
          condition: a.userList.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  AppCubit.get(context).messages = [];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatDetails(
                          image: a.userList[index].image,
                          name: a.userList[index].name,
                          uId: a.userList[index].uId,
                        )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                            a.userList[index].image),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(a.userList[index].name),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: a.userList.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
