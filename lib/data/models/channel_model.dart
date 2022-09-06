import 'package:flutter_twitch_clone/data/models/model.dart';

class ChannelModel extends Model {
  ChannelModel({
    this.broadcasterLanguage,
    this.broadcasterLogin,
    this.displayName,
    this.gameId,
    this.gameName,
    this.id,
    this.isLive,
    this.tagsIds,
    this.thumbnailUrl,
    this.title,
    this.startedAt,
  });

  String? broadcasterLanguage;
  String? broadcasterLogin;
  String? displayName;
  String? gameId;
  String? gameName;
  String? id;
  bool? isLive;
  List<dynamic>? tagsIds;
  String? thumbnailUrl;
  String? title;
  String? startedAt;

  ChannelModel copyWith({
    String? broadcasterLanguage,
    String? broadcasterLogin,
    String? displayName,
    String? gameId,
    String? gameName,
    String? id,
    bool? isLive,
    List<dynamic>? tagsIds,
    String? thumbnailUrl,
    String? title,
    String? startedAt,
  }) =>
      ChannelModel(
        broadcasterLanguage: broadcasterLanguage ?? this.broadcasterLanguage,
        broadcasterLogin: broadcasterLogin ?? this.broadcasterLogin,
        displayName: displayName ?? this.displayName,
        gameId: gameId ?? this.gameId,
        gameName: gameName ?? this.gameName,
        id: id ?? this.id,
        isLive: isLive ?? this.isLive,
        tagsIds: tagsIds ?? this.tagsIds,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        title: title ?? this.title,
        startedAt: startedAt ?? this.startedAt,
      );

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        broadcasterLanguage: json["broadcaster_language"],
        broadcasterLogin: json["broadcaster_login"],
        displayName: json["display_name"],
        gameId: json["game_id"],
        gameName: json["game_name"],
        id: json["id"],
        isLive: json["is_live"],
        tagsIds: json["tags_ids"] != null
            ? List<dynamic>.from(json["tags_ids"].map((x) => x))
            : json["tags_ids"],
        thumbnailUrl: json["thumbnail_url"],
        title: json["title"],
        startedAt: json["started_at"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "broadcaster_language": broadcasterLanguage,
        "broadcaster_login": broadcasterLogin,
        "display_name": displayName,
        "game_id": gameId,
        "game_name": gameName,
        "id": id,
        "is_live": isLive,
        "tags_ids": tagsIds != null
            ? List<dynamic>.from(tagsIds!.map((x) => x))
            : tagsIds,
        "thumbnail_url": thumbnailUrl,
        "title": title,
        "started_at": startedAt,
      };

  @override
  Model fromJson(json) {
    return ChannelModel.fromJson(json);
  }
}
