
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/model/message_model.dart';
import 'package:social_media_application/model/user_model.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';


class ChatDetails extends StatelessWidget {

  final String image;
  final String name;
  final String uId;

  ChatDetails({Key key, this.image, this.name, this.uId,}) : super(key: key);

  TextEditingController messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (BuildContext context) {

        if(AppCubit.get(context).messages.length == 0) AppCubit.get(context).getMessages(receiverId: uId);

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        image,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: AppCubit.get(context).messages.length > 0,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = AppCubit.get(context).messages[index];

                            if (AppCubit.get(context).model.uId ==
                                message.senderId)
                              return buildMyMessage(message);

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: AppCubit.get(context).messages.length,
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: kPrimaryColor,
                            child: MaterialButton(
                              onPressed: () {
                                AppCubit.get(context).sendMessage(
                                  receiverId: uId,
                                  dateTime: DateTime.now().toString(),
                                  messageText: messageController.text,
                                );
                              },
                              minWidth: 1.0,
                              child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0,
          horizontal: 10.0,),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(messageModel.messageText)),
  );
  Widget buildMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0,
          horizontal: 10.0,),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.3),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          ),
        ),
        child: Text(messageModel.messageText)),
  );
}
