class Brand {
  Brand({
    this.id,
    this.brandName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? brandName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    brandName: json["brand_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
