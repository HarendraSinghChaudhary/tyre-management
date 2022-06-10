class StoreCode {
  StoreCode({
    this.id,
    this.storeCode,
    this.storeName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? storeCode;
  String? storeName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StoreCode.fromJson(Map<String, dynamic> json) => StoreCode(
    id: json["id"],
    storeCode: json["store_code"],
    storeName: json["store_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_code": storeCode,
    "store_name": storeName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
