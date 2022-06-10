class Vendor {
  Vendor({
    this.id,
    this.vendorName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? vendorName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    vendorName: json["vendor_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_name": vendorName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
