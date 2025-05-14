/// id : 2
/// from_user : {"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true}
/// to_user : {"id":28,"avatar":null,"initial_name":"am","full_name":"ali mohammadi","is_online":true}
/// created_at : "2025-05-13T10:50:50.294000Z"
/// updated_at : "2025-05-13T10:50:50.294042Z"
/// is_active : true
/// status : "requested"
library;

class FriendModel {
  FriendModel({
    this.id,
    this.fromUser,
    this.toUser,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.status,
  });

  FriendModel.fromJson(dynamic json) {
    id = json['id'];
    fromUser =
        json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
    toUser = json['to_user'] != null ? ToUser.fromJson(json['to_user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    status = json['status'];
  }

  num? id;
  FromUser? fromUser;
  ToUser? toUser;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? status;

  FriendModel copyWith({
    num? id,
    FromUser? fromUser,
    ToUser? toUser,
    String? createdAt,
    String? updatedAt,
    bool? isActive,
    String? status,
  }) =>
      FriendModel(
        id: id ?? this.id,
        fromUser: fromUser ?? this.fromUser,
        toUser: toUser ?? this.toUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (fromUser != null) {
      map['from_user'] = fromUser?.toJson();
    }
    if (toUser != null) {
      map['to_user'] = toUser?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['status'] = status;
    return map;
  }
}

/// id : 28
/// avatar : null
/// initial_name : "am"
/// full_name : "ali mohammadi"
/// is_online : true

class ToUser {
  ToUser({
    this.id,
    this.avatar,
    this.initialName,
    this.fullName,
    this.isOnline,
  });

  ToUser.fromJson(dynamic json) {
    id = json['id'];
    avatar = json['avatar'];
    initialName = json['initial_name'];
    fullName = json['full_name'];
    isOnline = json['is_online'];
  }

  num? id;
  dynamic avatar;
  String? initialName;
  String? fullName;
  bool? isOnline;

  ToUser copyWith({
    num? id,
    dynamic avatar,
    String? initialName,
    String? fullName,
    bool? isOnline,
  }) =>
      ToUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        initialName: initialName ?? this.initialName,
        fullName: fullName ?? this.fullName,
        isOnline: isOnline ?? this.isOnline,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['avatar'] = avatar;
    map['initial_name'] = initialName;
    map['full_name'] = fullName;
    map['is_online'] = isOnline;
    return map;
  }
}

/// id : 20
/// avatar : null
/// initial_name : "MC"
/// full_name : "Mohammad Chavazi"
/// is_online : true

class FromUser {
  FromUser({
    this.id,
    this.avatar,
    this.initialName,
    this.fullName,
    this.isOnline,
  });

  FromUser.fromJson(dynamic json) {
    id = json['id'];
    avatar = json['avatar'];
    initialName = json['initial_name'];
    fullName = json['full_name'];
    isOnline = json['is_online'];
  }

  num? id;
  dynamic avatar;
  String? initialName;
  String? fullName;
  bool? isOnline;

  FromUser copyWith({
    num? id,
    dynamic avatar,
    String? initialName,
    String? fullName,
    bool? isOnline,
  }) =>
      FromUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        initialName: initialName ?? this.initialName,
        fullName: fullName ?? this.fullName,
        isOnline: isOnline ?? this.isOnline,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['avatar'] = avatar;
    map['initial_name'] = initialName;
    map['full_name'] = fullName;
    map['is_online'] = isOnline;
    return map;
  }
}
