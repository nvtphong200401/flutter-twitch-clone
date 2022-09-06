import 'model.dart';

class StreamModel extends Model {
  StreamModel({
    this.id,
    this.userId,
    this.userLogin,
    this.userName,
    this.gameId,
    this.gameName,
    this.type,
    this.title,
    this.viewerCount,
    this.startedAt,
    this.language,
    this.thumbnailUrl,
    this.tagIds,
  });

  String? id;
  String? userId;
  String? userLogin;
  String? userName;
  String? gameId;
  String? gameName;
  String? type;
  String? title;
  int? viewerCount;
  DateTime? startedAt;
  String? language;
  String? thumbnailUrl;
  List<String>? tagIds;

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        id: json["id"],
        userId: json["user_id"],
        userLogin: json["user_login"],
        userName: json["user_name"],
        gameId: json["game_id"],
        gameName: json["game_name"],
        type: json["type"],
        title: json["title"],
        viewerCount: json["viewer_count"],
        startedAt: DateTime.parse(json["started_at"]),
        language: json["language"],
        thumbnailUrl: json["thumbnail_url"],
        tagIds: json["tag_ids"] != null
            ? List<String>.from(json["tag_ids"].map((x) => x))
            : null,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_login": userLogin,
        "user_name": userName,
        "game_id": gameId,
        "game_name": gameName,
        "type": type,
        "title": title,
        "viewer_count": viewerCount,
        "started_at": startedAt?.toIso8601String(),
        "language": language,
        "thumbnail_url": thumbnailUrl,
        "tag_ids":
            tagIds == null ? tagIds : List<dynamic>.from(tagIds!.map((x) => x)),
      };

  StreamModel copyWith({
    String? id,
    String? userId,
    String? userLogin,
    String? userName,
    String? gameId,
    String? gameName,
    String? type,
    String? title,
    int? viewerCount,
    DateTime? startedAt,
    String? language,
    String? thumbnailUrl,
    List<String>? tagIds,
  }) =>
      StreamModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userLogin: userLogin ?? this.userLogin,
        userName: userName ?? this.userName,
        gameId: gameId ?? this.gameId,
        gameName: gameName ?? this.gameName,
        type: type ?? this.type,
        title: title ?? this.title,
        viewerCount: viewerCount ?? this.viewerCount,
        startedAt: startedAt ?? this.startedAt,
        language: language ?? this.language,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        tagIds: tagIds ?? this.tagIds,
      );

  @override
  Model fromJson(json) {
    return StreamModel.fromJson(json);
  }
}
