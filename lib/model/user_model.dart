class UserModel{
  String name;
  String phone;
  String email;
  String uId;
  String image;
  String coverImage;
  String bio;
  bool isEmailVerified;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.image,
    this.coverImage,
    this.bio,
    this.isEmailVerified = false,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image' : image,
      'coverImage' : coverImage,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }
}