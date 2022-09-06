import 'package:flutter_twitch_clone/data/models/model.dart';

class EventModel extends Model {
  String? id;
  String? status;
  String? type;
  String? version;
  Condition? condition;
  String? createdAt;
  Transport? transport;
  int? cost;

  EventModel(
      {this.id,
      this.status,
      this.type,
      this.version,
      this.condition,
      this.createdAt,
      this.transport,
      this.cost});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    type = json['type'];
    version = json['version'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    createdAt = json['created_at'];
    transport = json['transport'] != null
        ? Transport.fromJson(json['transport'])
        : null;
    cost = json['cost'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['type'] = type;
    data['version'] = version;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['created_at'] = createdAt;
    if (transport != null) {
      data['transport'] = transport!.toJson();
    }
    data['cost'] = cost;
    return data;
  }

  @override
  Model fromJson(json) {
    return fromJson(json);
  }
}

class Condition {
  String? broadcasterUserId;

  Condition({this.broadcasterUserId});

  Condition.fromJson(Map<String, dynamic> json) {
    broadcasterUserId = json['broadcaster_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['broadcaster_user_id'] = broadcasterUserId;
    return data;
  }
}

class Transport {
  String? method;
  String? callback;

  Transport({this.method, this.callback});

  Transport.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    callback = json['callback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['callback'] = callback;
    return data;
  }
}
