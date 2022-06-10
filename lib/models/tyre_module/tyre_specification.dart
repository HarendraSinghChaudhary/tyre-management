class TyreSpecification {
  TyreSpecification({
    this.id,
    this.specifictionName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? specifictionName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TyreSpecification.fromJson(Map<String, dynamic> json) => TyreSpecification(
    id: json["id"],
    specifictionName: json["specifiction_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "specifiction_name": specifictionName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
