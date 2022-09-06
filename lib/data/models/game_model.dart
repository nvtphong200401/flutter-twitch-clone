import 'model.dart';

class GameModel extends Model {
  GameModel({
    this.id,
    this.name,
    this.boxArtUrl,
  });

  String? id;
  String? name;
  String? boxArtUrl;

  GameModel copyWith({
    String? id,
    String? name,
    String? boxArtUrl,
  }) =>
      GameModel(
        id: id ?? this.id,
        name: name ?? this.name,
        boxArtUrl: boxArtUrl ?? this.boxArtUrl,
      );

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        id: json["id"],
        name: json["name"],
        boxArtUrl: json["box_art_url"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "box_art_url": boxArtUrl,
      };

  @override
  Model fromJson(json) {
    return GameModel.fromJson(json);
  }
}
