
class FuelingPointModel {
  FuelingPointModel({
    this.id,
    this.name,
    this.creatorId,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.townId,
  });

  int? id;
  String? name;
  int? creatorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? companyId;
  int? townId;

  factory FuelingPointModel.fromJson(Map<String, dynamic> json) => FuelingPointModel(
    id: json["id"],
    name: json["name"],
    creatorId: json["creator_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    companyId: json["company_id"],
    townId: json["town_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "company_id": companyId,
    "town_id": townId,
  };
}
