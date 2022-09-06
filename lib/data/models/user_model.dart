import 'model.dart';

class UserModel extends Model {
  UserModel({
    this.id,
    this.login,
    this.displayName,
    this.type,
    this.broadcasterType,
    this.description,
    this.profileImageUrl,
    this.offlineImageUrl,
    this.viewCount,
    this.email,
    this.createdAt,
  });

  String? id;
  String? login;
  String? displayName;
  String? type;
  String? broadcasterType;
  String? description;
  String? profileImageUrl;
  String? offlineImageUrl;
  int? viewCount;
  String? email;
  DateTime? createdAt;

  UserModel copyWith({
    String? id,
    String? login,
    String? displayName,
    String? type,
    String? broadcasterType,
    String? description,
    String? profileImageUrl,
    String? offlineImageUrl,
    int? viewCount,
    String? email,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        login: login ?? this.login,
        displayName: displayName ?? this.displayName,
        type: type ?? this.type,
        broadcasterType: broadcasterType ?? this.broadcasterType,
        description: description ?? this.description,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        offlineImageUrl: offlineImageUrl ?? this.offlineImageUrl,
        viewCount: viewCount ?? this.viewCount,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        login: json["login"],
        displayName: json["display_name"],
        type: json["type"],
        broadcasterType: json["broadcaster_type"],
        description: json["description"],
        profileImageUrl: json["profile_image_url"],
        offlineImageUrl: json["offline_image_url"],
        viewCount: json["view_count"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
      );
  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "display_name": displayName,
        "type": type,
        "broadcaster_type": broadcasterType,
        "description": description,
        "profile_image_url": profileImageUrl,
        "offline_image_url": offlineImageUrl,
        "view_count": viewCount,
        "email": email,
        "created_at": createdAt != null
            ? createdAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
      };

  @override
  Model fromJson(json) {
    return UserModel.fromJson(json);
  }
}
