/// id : 1
/// created_at : "2022-03-16T11:18:14+00:00"
/// data : "test"
/// type : "text"
/// uuid : "3227937a-27d6-4a16-b129-ba21da868bd7"

class DataModel {
  bool expanded = false;

  DataModel({
    this.id,
    this.createdAt,
    this.data,
    this.type,
    this.expanded = false,
    this.uuid,
  });

  DataModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    data = json['data'];
    type = json['type'];
    uuid = json['uuid'];
  }

  int? id;
  String? createdAt;
  String? data;
  String? type;
  String? uuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['type'] = type;
    map['uuid'] = uuid;
    return map;
  }
}
