class TyreSize {
  TyreSize({
    this.id,
    this.sizeName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? sizeName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TyreSize.fromJson(Map<String, dynamic> json) => TyreSize(
    id: json["id"],
    sizeName: json["size_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size_name": sizeName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
