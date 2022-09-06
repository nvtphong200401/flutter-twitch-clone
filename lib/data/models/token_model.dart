import 'package:flutter_twitch_clone/data/models/model.dart';

class TokenModel extends Model {
  TokenModel({
    this.clientId,
    this.login,
    this.scopes,
    this.userId,
    this.expiresIn,
    this.status,
    this.message,
  });

  String? clientId;
  String? login;
  List<String>? scopes;
  String? userId;
  int? expiresIn;
  int? status;
  String? message;

  TokenModel copyWith({
    String? clientId,
    String? login,
    List<String>? scopes,
    String? userId,
    int? expiresIn,
    int? status,
    String? message,
  }) =>
      TokenModel(
        clientId: clientId ?? this.clientId,
        login: login ?? this.login,
        scopes: scopes ?? this.scopes,
        userId: userId ?? this.userId,
        expiresIn: expiresIn ?? this.expiresIn,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        clientId: json["client_id"],
        login: json["login"],
        scopes: json["scopes"] != null
            ? List<String>.from(json["scopes"].map((x) => x))
            : null,
        userId: json["user_id"],
        expiresIn: json["expires_in"],
        status: json["status"] == null ? 200 : 401,
        message: json["message"] ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "login": login,
        "scopes":
            scopes == null ? scopes : List<dynamic>.from(scopes!.map((x) => x)),
        "user_id": userId,
        "expires_in": expiresIn,
        "status": status,
        "message": message,
      };

  @override
  Model fromJson(json) {
    return TokenModel.fromJson(json);
  }
}
