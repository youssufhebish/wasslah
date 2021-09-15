import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_application/cubit/state.dart';
import 'package:social_media_application/model/message_model.dart';
import 'package:social_media_application/model/post_model.dart';
import 'package:social_media_application/model/user_model.dart';
import 'package:social_media_application/modules/chat/chat_screen.dart';
import 'package:social_media_application/modules/feeds/feed_screen.dart';
import 'package:social_media_application/modules/notifications/notifications_screen.dart';
import 'package:social_media_application/modules/profile/settings_screen.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String e;

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
      e = error;
      emit(LogInErrorState(error));
    });
  }

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user.uid,
      );
      emit(RegisterDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  UserModel model = UserModel();

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
    String bio,
  }) {
    emit(CreateLoadingState());
    model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://isobarscience.com/wp-content/uploads/2020/09/default-profile-picture1.jpg',
      coverImage: 'https://newevolutiondesigns.com/images/freebies/purple-facebook-cover-13.jpg',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap())
        .then((value) {
      emit(CreateDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateErrorState());
    });
  }

  void getUserData(){
    if(uId == "")
      return ;
    else{
      emit(GetUserDataInitialState());
    FirebaseFirestore.instance.collection('users').doc(uId).get()
        .then((value) {
      model = UserModel.fromJson(value.data());
      print(model.image);
      print(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(GetUserDataErrorState());
    });
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  List<String> title = [
    'News Feeds'.toUpperCase(),
    'chats'.toUpperCase(),
    'profile'.toUpperCase(),
  ];
  void indexChange(int i){
    if(i == 1) getAllUser();
    currentIndex = i;
    emit(ChangeNavBarState());
  }

  var picker = ImagePicker();
  File profileImage;

  Future<void> getProfileImage() async{
    final _pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if(_pickedFile != null) {
      profileImage = File(_pickedFile.path);
      emit(SelectProfilePICSuccessState());
    } else {
      print('no image selected');
      emit(SelectProfilePICErrorState());
    }
  }

  File coverImage;

 Future<void> getCoverImage() async{
   final _pickedFile = await picker.pickImage(source: ImageSource.gallery,);

   if(_pickedFile != null){
     coverImage = File(_pickedFile.path);
     emit(SelectCoverPICSuccessState());
   } else {
     print('no image selected');
     emit(SelectCoverPICErrorState());
   }
 }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  })
  {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name:name,
          phone:phone,
          bio:bio,
          image:value,
        );
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  })
  {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name:name,
          phone:phone,
          bio:bio,
          cover:value,
        );
        emit(UploadCoverImageSuccessState());
      }).catchError((error)
      {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error)
    {
      emit(UploadCoverImageErrorState());
    });
  }

  // void uploadCoverImage() {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage.path).pathSegments.last}')
  //       .putFile(coverImage)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //     });
  //     print(value);
  //     emit(UploadCoverImageSuccessState());
  //   }).catchError((e) {
  //     emit(UploadCoverImageErrorState());
  //   });
  // }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
   UserModel _model = UserModel(
     name: name,
     phone: phone,
     bio: bio,
     email: model.email,
     coverImage: cover ?? model.coverImage,
     image: image??model.image,
     uId: model.uId,
     isEmailVerified: false,
   );

   FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(_model.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError((e) {
      emit(UpdateUserErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async{
    final _pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if(_pickedFile != null){
      postImage = File(_pickedFile.path);
      emit(CreatePostSuccessState());
    } else {
      print('no image selected');
      emit(CreatePostErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  })
  {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        print(value);
        emit(CreatePostSuccessState());
      }).catchError((error)
      {
        emit(CreatePostErrorState());
      });
    }).catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }

  PostModel postModel = PostModel();

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel _model = PostModel(
      name: model.name,
      image: model.image,
      uId: model.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(_model.toMap())
        .then((value) {
          print(value);
      emit(CreatePostSuccessState());
    }).catchError((e) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts').get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          if(model.uId == element.data()['uId']){
            likes.add(value.docs.length);
            postId.add((element.id));
            posts.add(PostModel.fromJson(element.data()));
          }
        }).catchError((e) {});
      });
      print('done');
      emit(GetPostsSuccessState());
    })
        .catchError((e) {
      print(e.toString());
      print('false');
      emit(GetPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((e) {
      emit(PostLikeSuccessState());
    });
  }

  List<UserModel> userList = [];

  void getAllUser(){
    emit(GetAllUserDataInitialState());
    if(userList.length == 0)
    FirebaseFirestore.instance.collection('users').get()
        .then((value) {
      value.docs.forEach((element) {
        if(model.uId != element.data()['uId'])
        userList.add(UserModel.fromJson(element.data()));
        print(model.uId);
      });
      emit(GetAllUserDataSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(GetAllUserDataErrorState());
    });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String messageText,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: model.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      messageText: messageText,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      print('a');
      emit(GetMessageSuccessState());
    });
  }

  void getAllMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .get()
        .then((value) {
      messages = [];
      value.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      print('a');
      emit(GetMessageSuccessState());
    }).catchError((e) {});
  }

  void makeFalse(bool a){
    a = false;
    emit(PostLikeSuccessState());
  }

  void makeTrue(bool a){
    a = true;
    emit(PostLikeSuccessState());
  }
}