/// count : 1
/// next : null
/// previous : null
/// results : [{"id":4,"children":[],"author":{"relation":"Unknown","member":{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":false},"family":"Chavazi family","is_active":true},"likes":{"counter":0,"users":[]},"created_at":"2025-05-07T00:03:59.812335Z","updated_at":"2025-05-07T00:03:59.812373Z","is_active":true,"text":"hello","post":6}]
library;

class CommentsModel {
  CommentsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  CommentsModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Comments.fromJson(v));
      });
    }
  }

  num? count;
  dynamic next;
  dynamic previous;
  List<Comments>? results;

  CommentsModel copyWith({
    num? count,
    dynamic next,
    dynamic previous,
    List<Comments>? results,
  }) =>
      CommentsModel(
        count: count ?? this.count,
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

/// id : 4
/// children : []
/// author : {"relation":"Unknown","member":{"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":false},"family":"Chavazi family","is_active":true}
/// likes : {"counter":0,"users":[]}
/// created_at : "2025-05-07T00:03:59.812335Z"
/// updated_at : "2025-05-07T00:03:59.812373Z"
/// is_active : true
/// text : "hello"
/// post : 6

class Comments {
  Comments({
    this.id,
    this.author,
    this.likes,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.text,
    this.post,
  });

  Comments.fromJson(dynamic json) {
    id = json['id'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    likes = json['likes'] != null ? Likes.fromJson(json['likes']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    text = json['text'];
    post = json['post'];
  }

  num? id;
  List<dynamic>? children;
  Author? author;
  Likes? likes;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? text;
  num? post;

  Comments copyWith({
    num? id,
    List<dynamic>? children,
    Author? author,
    Likes? likes,
    String? createdAt,
    String? updatedAt,
    bool? isActive,
    String? text,
    num? post,
  }) =>
      Comments(
        id: id ?? this.id,
        author: author ?? this.author,
        likes: likes ?? this.likes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        text: text ?? this.text,
        post: post ?? this.post,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (likes != null) {
      map['likes'] = likes?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['text'] = text;
    map['post'] = post;
    return map;
  }
}

/// counter : 0
/// users : []

class Likes {
  Likes({
    this.counter,
    this.users,
  });

  Likes.fromJson(dynamic json) {
    counter = json['counter'];
  }

  num? counter;
  List<dynamic>? users;

  Likes copyWith({
    num? counter,
  }) =>
      Likes(
        counter: counter ?? this.counter,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['counter'] = counter;
    return map;
  }
}

/// relation : "Unknown"
/// member : {"id":20,"avatar":null,"initial_name":"MC","full_name":"Mohammad Chavazi","is_online":false}
/// family : "Chavazi family"
/// is_active : true

class Author {
  Author({
    this.relation,
    this.member,
    this.family,
    this.isActive,
  });

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

  Author copyWith({
    String? relation,
    Member? member,
    String? family,
    bool? isActive,
  }) =>
      Author(
        relation: relation ?? this.relation,
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
/// is_online : false

class Member {
  Member({
    this.id,
    this.avatar,
    this.initialName,
    this.fullName,
    this.isOnline,
  });

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

  Member copyWith({
    num? id,
    dynamic avatar,
    String? initialName,
    String? fullName,
    bool? isOnline,
  }) =>
      Member(
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
