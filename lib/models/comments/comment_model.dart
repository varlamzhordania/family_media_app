/// count : 123
/// next : "http://api.example.org/accounts/?page=4"
/// previous : "http://api.example.org/accounts/?page=2"
/// results : [{"id":0,"author":{"relation":"string","member":{"id":0,"avatar":"string","initial_name":"string","full_name":"string","is_online":true},"family":"string","is_active":true},"likes":"string","created_at":"2025-05-08T09:30:02.315Z","updated_at":"2025-05-08T09:30:02.315Z","is_active":true,"text":"string","post":0}]
library;

class CommentModel {
  CommentModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  CommentModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Comment.fromJson(v));
      });
    }
  }
  num? count;
  String? next;
  String? previous;
  List<Comment>? results;
CommentModel copyWith({  num? count,
  String? next,
  String? previous,
  List<Comment>? results,
}) => CommentModel(  count: count ?? this.count,
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

/// id : 0
/// author : {"relation":"string","member":{"id":0,"avatar":"string","initial_name":"string","full_name":"string","is_online":true},"family":"string","is_active":true}
/// likes : "string"
/// created_at : "2025-05-08T09:30:02.315Z"
/// updated_at : "2025-05-08T09:30:02.315Z"
/// is_active : true
/// text : "string"
/// post : 0

class Comment {
  Comment({
      this.id, 
      this.author, 
      this.likes, 
      this.createdAt, 
      this.updatedAt, 
      this.isActive, 
      this.text, 
      this.post,});

  Comment.fromJson(dynamic json) {
    id = json['id'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    likes = json['likes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    text = json['text'];
    post = json['post'];
  }
  num? id;
  Author? author;
  String? likes;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? text;
  num? post;
  Comment copyWith({  num? id,
  Author? author,
  String? likes,
  String? createdAt,
  String? updatedAt,
  bool? isActive,
  String? text,
  num? post,
}) => Comment(  id: id ?? this.id,
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
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['likes'] = likes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['text'] = text;
    map['post'] = post;
    return map;
  }

}

/// relation : "string"
/// member : {"id":0,"avatar":"string","initial_name":"string","full_name":"string","is_online":true}
/// family : "string"
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

/// id : 0
/// avatar : "string"
/// initial_name : "string"
/// full_name : "string"
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
  String? avatar;
  String? initialName;
  String? fullName;
  bool? isOnline;
Member copyWith({  num? id,
  String? avatar,
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