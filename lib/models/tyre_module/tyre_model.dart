class TyreModel {
  TyreModel({
    this.id,
    this.modelName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? modelName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TyreModel.fromJson(Map<String, dynamic> json) => TyreModel(
    id: json["id"],
    modelName: json["model_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "model_name": modelName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
