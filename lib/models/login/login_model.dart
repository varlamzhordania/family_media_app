/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlJoblAzNGlydGRTSW9LaXNYNmtGYVBJS3l5dGVFaCJ9.Ho_3SPx7QDnZ4u4NYICD5kpZRkKdYIRrPBFSHFVjfgw"
/// expires_in : 15770000.0
/// token_type : "Bearer"
/// scope : "read write"
/// refresh_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ikp3enFPdFdYdlRYV1pUT1BWUGEySEJaUHpQaHdEWSJ9.D40Jl7oTfr8Zk5ZlUx5Yz8KE3XaqvSfEBZxQfSbzpzc"
library;

class LoginModel {
  LoginModel({
      this.accessToken, 
      this.expiresIn, 
      this.tokenType, 
      this.scope, 
      this.refreshToken,});

  LoginModel.fromJson(dynamic json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    scope = json['scope'];
    refreshToken = json['refresh_token'];
  }
  String? accessToken;
  num? expiresIn;
  String? tokenType;
  String? scope;
  String? refreshToken;
LoginModel copyWith({  String? accessToken,
  num? expiresIn,
  String? tokenType,
  String? scope,
  String? refreshToken,
}) => LoginModel(  accessToken: accessToken ?? this.accessToken,
  expiresIn: expiresIn ?? this.expiresIn,
  tokenType: tokenType ?? this.tokenType,
  scope: scope ?? this.scope,
  refreshToken: refreshToken ?? this.refreshToken,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['expires_in'] = expiresIn;
    map['token_type'] = tokenType;
    map['scope'] = scope;
    map['refresh_token'] = refreshToken;
    return map;
  }

}