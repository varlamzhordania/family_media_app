/// id : 0
/// first_name : "string"
/// last_name : "string"
/// email : "user@example.com"
/// avatar : "string"
/// bg_cover : "string"
/// bio : "string"
/// phone_number : "string"
/// is_online : true

class RegisterModel {
  RegisterModel({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.avatar, 
      this.bgCover, 
      this.bio, 
      this.phoneNumber, 
      this.isOnline,});

  RegisterModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    avatar = json['avatar'];
    bgCover = json['bg_cover'];
    bio = json['bio'];
    phoneNumber = json['phone_number'];
    isOnline = json['is_online'];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  String? bgCover;
  String? bio;
  String? phoneNumber;
  bool? isOnline;
RegisterModel copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? email,
  String? avatar,
  String? bgCover,
  String? bio,
  String? phoneNumber,
  bool? isOnline,
}) => RegisterModel(  id: id ?? this.id,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  avatar: avatar ?? this.avatar,
  bgCover: bgCover ?? this.bgCover,
  bio: bio ?? this.bio,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  isOnline: isOnline ?? this.isOnline,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['avatar'] = avatar;
    map['bg_cover'] = bgCover;
    map['bio'] = bio;
    map['phone_number'] = phoneNumber;
    map['is_online'] = isOnline;
    return map;
  }

}