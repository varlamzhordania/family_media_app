/// count : 1
/// next : null
/// previous : null
/// results : [{"id":6,"medias":[{"is_featured":false,"file":"https://api.familyarbore.com/media/posts/media/20250503_005552.jpeg","ext":".jpeg"}],"likes":{"counter":1,"users":[34]},"author":{"relation":"Unknown","member":{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true},"family":"Chavazi family","is_active":true},"created_at":"2025-05-03T00:55:52.152141Z","updated_at":"2025-05-03T00:55:52.152193Z","text":"helllo family","is_active":true}]
library;

class PostsModel {
  PostsModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  PostsModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Post.fromJson(v));
      });
    }
  }
  num? count;
  dynamic next;
  dynamic previous;
  List<Post>? results;
PostsModel copyWith({  num? count,
  dynamic next,
  dynamic previous,
  List<Post>? results,
}) => PostsModel(  count: count ?? this.count,
  next: next ?? this.next,
  previous: previous ?? this.previous,
  results: results ?? this.results,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 6
/// medias : [{"is_featured":false,"file":"https://api.familyarbore.com/media/posts/media/20250503_005552.jpeg","ext":".jpeg"}]
/// likes : {"counter":1,"users":[34]}
/// author : {"relation":"Unknown","member":{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true},"family":"Chavazi family","is_active":true}
/// created_at : "2025-05-03T00:55:52.152141Z"
/// updated_at : "2025-05-03T00:55:52.152193Z"
/// text : "helllo family"
/// is_active : true

class Post {
  Post({
      this.id, 
      this.medias, 
      this.likes, 
      this.author, 
      this.createdAt, 
      this.updatedAt, 
      this.text, 
      this.isActive,});

  Post.fromJson(dynamic json) {
    id = json['id'];
    if (json['medias'] != null) {
      medias = [];
      json['medias'].forEach((v) {
        medias?.add(Medias.fromJson(v));
      });
    }
    likes = json['likes'] != null ? Likes.fromJson(json['likes']) : null;
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    text = json['text'];
    isActive = json['is_active'];
  }
  num? id;
  List<Medias>? medias;
  Likes? likes;
  Author? author;
  String? createdAt;
  String? updatedAt;
  String? text;
  bool? isActive;
  Post copyWith({  num? id,
  List<Medias>? medias,
  Likes? likes,
  Author? author,
  String? createdAt,
  String? updatedAt,
  String? text,
  bool? isActive,
}) => Post(  id: id ?? this.id,
  medias: medias ?? this.medias,
  likes: likes ?? this.likes,
  author: author ?? this.author,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  text: text ?? this.text,
  isActive: isActive ?? this.isActive,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (medias != null) {
      map['medias'] = medias?.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      map['likes'] = likes?.toJson();
    }
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['text'] = text;
    map['is_active'] = isActive;
    return map;
  }

}

/// relation : "Unknown"
/// member : {"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":true}
/// family : "Chavazi family"
/// is_active : true

class Author {
  Author({
      this.relation, 
      this.member, 
      this.family, 
      this.isActive,});

  Author.fromJson(dynamic json) {
    relation = json['relation'];
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    family = json['family'];
    isActive = json['is_active'];
  }
  String? relation;
  Member? member;
  String? family;
  bool? isActive;
Author copyWith({  String? relation,
  Member? member,
  String? family,
  bool? isActive,
}) => Author(  relation: relation ?? this.relation,
  member: member ?? this.member,
  family: family ?? this.family,
  isActive: isActive ?? this.isActive,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['relation'] = relation;
    if (member != null) {
      map['member'] = member?.toJson();
    }
    map['family'] = family;
    map['is_active'] = isActive;
    return map;
  }

}

/// id : 20
/// avatar : null
/// initial_name : "MC"
/// full_name : "Mohammad Chavazi"
/// is_online : true

class Member {
  Member({
      this.id, 
      this.avatar, 
      this.initialName, 
      this.fullName, 
      this.isOnline,});

  Member.fromJson(dynamic json) {
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
Member copyWith({  num? id,
  dynamic avatar,
  String? initialName,
  String? fullName,
  bool? isOnline,
}) => Member(  id: id ?? this.id,
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

/// counter : 1
/// users : [34]

class Likes {
  Likes({
      this.counter, 
      this.users,});

  Likes.fromJson(dynamic json) {
    counter = json['counter'];
    users = json['users'] != null ? json['users'].cast<num>() : [];
  }
  num? counter;
  List<num>? users;
Likes copyWith({  num? counter,
  List<num>? users,
}) => Likes(  counter: counter ?? this.counter,
  users: users ?? this.users,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['counter'] = counter;
    map['users'] = users;
    return map;
  }

}

/// is_featured : false
/// file : "https://api.familyarbore.com/media/posts/media/20250503_005552.jpeg"
/// ext : ".jpeg"

class Medias {
  Medias({
      this.isFeatured, 
      this.file, 
      this.ext,});

  Medias.fromJson(dynamic json) {
    isFeatured = json['is_featured'];
    file = json['file'];
    ext = json['ext'];
  }
  bool? isFeatured;
  String? file;
  String? ext;
Medias copyWith({  bool? isFeatured,
  String? file,
  String? ext,
}) => Medias(  isFeatured: isFeatured ?? this.isFeatured,
  file: file ?? this.file,
  ext: ext ?? this.ext,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_featured'] = isFeatured;
    map['file'] = file;
    map['ext'] = ext;
    return map;
  }

}