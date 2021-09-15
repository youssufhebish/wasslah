
abstract class AppStates {}

class AppInitialState extends AppStates{}


abstract class LogInStates {}

class LogInInitialState extends AppStates{}

class LogInLoadingState extends AppStates{}

class LogInDoneState extends AppStates{}

class LogInErrorState extends AppStates{
  String error;
  LogInErrorState(this.error);
}

class RegisterInitialState extends AppStates{}

class RegisterLoadingState extends AppStates{}

class RegisterDoneState extends AppStates{}

class RegisterErrorState extends AppStates{}

class CreateLoadingState extends AppStates{}

class CreateDoneState extends AppStates{}

class CreateErrorState extends AppStates{}

class ChangeNavBarState extends AppStates{}

class GetUserDataInitialState extends AppStates{}

class GetUserDataSuccessState extends AppStates{}

class GetUserDataErrorState extends AppStates{}

class GetAllUserDataInitialState extends AppStates{}

class GetAllUserDataSuccessState extends AppStates{}

class GetAllUserDataErrorState extends AppStates{}

class SelectProfilePICSuccessState extends AppStates{}

class SelectCoverPICSuccessState extends AppStates{}

class SelectProfilePICErrorState extends AppStates{}

class SelectCoverPICErrorState extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadCoverImageSuccessState extends AppStates{}

class UploadProfileImageErrorState extends AppStates{}

class UploadCoverImageErrorState extends AppStates{}

class UpdateUserSuccessState extends AppStates{}

class UpdateUserErrorState extends AppStates{}

class UserUpdateLoadingState extends AppStates{}

class SelectPostImageLoadingState extends AppStates{}

class SelectPostImageSuccessState extends AppStates{}

class SelectPostImageErrorState extends AppStates{}

class CreatePostLoadingState extends AppStates{}

class CreatePostSuccessState extends AppStates{}

class CreatePostErrorState extends AppStates{}

class RemovePostImageState extends AppStates{}

class GetPostsLoadingState extends AppStates{}

class GetPostsSuccessState extends AppStates{}

class GetPostsErrorState extends AppStates{}

class PostLikeSuccessState extends AppStates{}

class PostLikeErrorState extends AppStates{}

class GetMessageSuccessState extends AppStates{}

class GetMessageErrorState extends AppStates{}

class SendMessageSuccessState extends AppStates{}

class SendMessageErrorState extends AppStates{}