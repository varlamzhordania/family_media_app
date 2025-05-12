/// id : 34
/// family : {"id":26,"established":"established 1 week, 4 days ago","members":[{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true},{"id":27,"avatar":null,"initial_name":"am","full_name":"alex montana","is_online":false}],"created_at":"2025-05-01T12:24:31.326506Z","updated_at":"2025-05-09T02:20:21.015261Z","is_active":true,"name":"Chavazi family","description":"Hello my children","avatar":"https://api.familyarbore.com/media/pictures/avatars/20250501_122623.jpeg","bg_cover":"https://api.familyarbore.com/media/pictures/covers/20250501_122543.jpeg","invite_code":"DZF7ZAXVPJ","creator":20,"admins":[]}
/// created_at : "2025-05-01T12:24:31.340079Z"
/// updated_at : "2025-05-01T12:24:31.340104Z"
/// is_active : true
/// relation : "Unknown"
/// member : 20
library;

class MemberModel {
  MemberModel({
    this.id,
    this.family,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.relation,
    this.member,
  });

  MemberModel.fromJson(dynamic json) {
    id = json['id'];
    family = json['family'] != null ? Family.fromJson(json['family']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    relation = json['relation'];
    member = json['member'];
  }

  num? id;
  Family? family;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? relation;
  num? member;

  MemberModel copyWith({
    num? id,
    Family? family,
    String? createdAt,
    String? updatedAt,
    bool? isActive,
    String? relation,
    num? member,
  }) =>
      MemberModel(
        id: id ?? this.id,
        family: family ?? this.family,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        relation: relation ?? this.relation,
        member: member ?? this.member,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (family != null) {
      map['family'] = family?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['relation'] = relation;
    map['member'] = member;
    return map;
  }
}

/// id : 26
/// established : "established 1 week, 4 days ago"
/// members : [{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true},{"id":27,"avatar":null,"initial_name":"am","full_name":"alex montana","is_online":false}]
/// created_at : "2025-05-01T12:24:31.326506Z"
/// updated_at : "2025-05-09T02:20:21.015261Z"
/// is_active : true
/// name : "Chavazi family"
/// description : "Hello my children"
/// avatar : "https://api.familyarbore.com/media/pictures/avatars/20250501_122623.jpeg"
/// bg_cover : "https://api.familyarbore.com/media/pictures/covers/20250501_122543.jpeg"
/// invite_code : "DZF7ZAXVPJ"
/// creator : 20
/// admins : []

class Family {
  Family({
    this.id,
    this.established,
    this.members,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.name,
    this.description,
    this.avatar,
    this.bgCover,
    this.inviteCode,
    this.creator,
  });

  Family.fromJson(dynamic json) {
    id = json['id'];
    established = json['established'];
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members?.add(Members.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    bgCover = json['bg_cover'];
    inviteCode = json['invite_code'];
    creator = json['creator'];
  }

  num? id;
  String? established;
  List<Members>? members;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? description;
  String? avatar;
  String? bgCover;
  String? inviteCode;
  num? creator;
  Family copyWith({
    num? id,
    String? established,
    List<Members>? members,
    String? createdAt,
    String? updatedAt,
    bool? isActive,
    String? name,
    String? description,
    String? avatar,
    String? bgCover,
    String? inviteCode,
    num? creator,
    List<dynamic>? admins,
  }) =>
      Family(
        id: id ?? this.id,
        established: established ?? this.established,
        members: members ?? this.members,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        name: name ?? this.name,
        description: description ?? this.description,
        avatar: avatar ?? this.avatar,
        bgCover: bgCover ?? this.bgCover,
        inviteCode: inviteCode ?? this.inviteCode,
        creator: creator ?? this.creator,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['established'] = established;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['name'] = name;
    map['description'] = description;
    map['avatar'] = avatar;
    map['bg_cover'] = bgCover;
    map['invite_code'] = inviteCode;
    map['creator'] = creator;
    return map;
  }
}

/// id : 20
/// avatar : null
/// initial_name : "MC"
/// full_name : "Mohammad Chavazi"
/// is_online : true

class Members {
  Members({
    this.id,
    this.avatar,
    this.initialName,
    this.fullName,
    this.isOnline,
  });

  Members.fromJson(dynamic json) {
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

  Members copyWith({
    num? id,
    dynamic avatar,
    String? initialName,
    String? fullName,
    bool? isOnline,
  }) =>
      Members(
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
