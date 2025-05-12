
class ForgotModel {
  ForgotModel({
      this.message,});

  ForgotModel.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;
ForgotModel copyWith({  String? message,
}) => ForgotModel(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}