import 'package:flutter_twitch_clone/data/models/model.dart';

class VideoModel extends Model {
  VideoModel({
    this.id,
    this.streamId,
    this.userId,
    this.userLogin,
    this.userName,
    this.title,
    this.description,
    this.createdAt,
    this.publishedAt,
    this.url,
    this.thumbnailUrl,
    this.viewable,
    this.viewCount,
    this.language,
    this.type,
    this.duration,
    this.mutedSegments,
  });

  String? id;
  dynamic streamId;
  String? userId;
  String? userLogin;
  String? userName;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? publishedAt;
  String? url;
  String? thumbnailUrl;
  String? viewable;
  int? viewCount;
  String? language;
  String? type;
  String? duration;
  List<MutedSegment>? mutedSegments;

  VideoModel copyWith({
    String? id,
    dynamic streamId,
    String? userId,
    String? userLogin,
    String? userName,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? publishedAt,
    String? url,
    String? thumbnailUrl,
    String? viewable,
    int? viewCount,
    String? language,
    String? type,
    String? duration,
    List<MutedSegment>? mutedSegments,
  }) =>
      VideoModel(
        id: id ?? this.id,
        streamId: streamId ?? this.streamId,
        userId: userId ?? this.userId,
        userLogin: userLogin ?? this.userLogin,
        userName: userName ?? this.userName,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        publishedAt: publishedAt ?? this.publishedAt,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        viewable: viewable ?? this.viewable,
        viewCount: viewCount ?? this.viewCount,
        language: language ?? this.language,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        mutedSegments: mutedSegments ?? this.mutedSegments,
      );

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        streamId: json["stream_id"],
        userId: json["user_id"],
        userLogin: json["user_login"],
        userName: json["user_name"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        publishedAt: DateTime.parse(json["published_at"]),
        url: json["url"],
        thumbnailUrl: json["thumbnail_url"],
        viewable: json["viewable"],
        viewCount: json["view_count"],
        language: json["language"],
        type: json["type"],
        duration: json["duration"],
        mutedSegments: json["muted_segments"] != null
            ? List<MutedSegment>.from(
                json["muted_segments"].map((x) => MutedSegment.fromJson(x)))
            : json["muted_segments"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "stream_id": streamId,
        "user_id": userId,
        "user_login": userLogin,
        "user_name": userName,
        "title": title,
        "description": description,
        "created_at": createdAt != null
            ? createdAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
        "published_at": publishedAt != null
            ? publishedAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
        "url": url,
        "thumbnail_url": thumbnailUrl,
        "viewable": viewable,
        "view_count": viewCount,
        "language": language,
        "type": type,
        "duration": duration,
        "muted_segments": mutedSegments == null
            ? mutedSegments
            : List<dynamic>.from(mutedSegments!.map((x) => x.toJson())),
      };

  @override
  Model fromJson(json) {
    return VideoModel.fromJson(json);
  }
}

class MutedSegment {
  MutedSegment({
    this.duration,
    this.offset,
  });

  int? duration;
  int? offset;

  MutedSegment copyWith({
    int? duration,
    int? offset,
  }) =>
      MutedSegment(
        duration: duration ?? this.duration,
        offset: offset ?? this.offset,
      );

  factory MutedSegment.fromJson(Map<String, dynamic> json) => MutedSegment(
        duration: json["duration"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "offset": offset,
      };
}
