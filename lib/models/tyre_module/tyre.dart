class Tyre {
  Tyre({
    this.id,
    this.tyreStoreId,
    this.tyreSizeId,
    this.tyreModelId,
    this.tyreWeight,
    this.tyreWidth,
    this.tyreBrandId,
    this.tyreTreadPatternId,
    this.treadDepth,
    this.tyreSpecificationId,
    this.tyreVendorId,
    this.tyrePurchaseDate,
    this.tyreWarrantyPeriod,
    this.tyreWarrantyExpireDate,
    this.tyreWarrantyKms,
    this.tyreImage,
    this.tyrePsi,
    this.tyreDeployOn,
    this.tyreVehicleId,
    this.tyreVehicleOdometer,
    this.tyreAxelId,
    this.tyrePosition,
    this.tyreDismountReasion,
    this.tyreStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? tyreStoreId;
  String? tyreSizeId;
  String? tyreModelId;
  String? tyreWeight;
  String? tyreWidth;
  String? tyreBrandId;
  String? tyreTreadPatternId;
  String? treadDepth;
  String? tyreSpecificationId;
  String? tyreVendorId;
  DateTime? tyrePurchaseDate;
  String? tyreWarrantyPeriod;
  DateTime? tyreWarrantyExpireDate;
  String? tyreWarrantyKms;
  String? tyreImage;
  dynamic tyrePsi;
  dynamic tyreDeployOn;
  dynamic tyreVehicleId;
  dynamic tyreVehicleOdometer;
  dynamic tyreAxelId;
  dynamic tyrePosition;
  String? tyreDismountReasion;
  String? tyreStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Tyre.fromJson(Map<String, dynamic> json) => Tyre(
        id: json["id"],
        tyreStoreId: json["tyre_store_id"].toString() == "null"
            ? "null"
            : json["tyre_store_id"].toString(),
        tyreSizeId: json["tyre_size_id"].toString(),
        tyreModelId: json["tyre_model_id"].toString(),
        tyreWeight: json["tyre_weight"].toString(),
        tyreWidth: json["tyre_width"].toString(),
        tyreBrandId: json["tyre_brand_id"].toString(),
        tyreTreadPatternId: json["tyre_tread_pattern_id"].toString(),
        treadDepth: json["tread_depth"].toString(),
        tyreSpecificationId: json["tyre_specification_id"].toString(),
        tyreVendorId: json["tyre_vendor_id"].toString(),
        // tyrePurchaseDate: DateTime.parse(json["tyre_purchase_date"].toString()),
        tyreWarrantyPeriod: json["tyre_warranty_period"].toString(),
        tyreWarrantyExpireDate:
            DateTime.parse(json["tyre_warranty_expire_date"].toString()),
        tyreWarrantyKms: json["tyre_warranty_kms"].toString(),
        tyreImage: json["tyre_image"].toString(),
        tyrePsi: json["tyre_psi"].toString(),
        tyreDeployOn: json["tyre_deploy_on"].toString(),
        tyreVehicleId: json["tyre_vehicle_id"].toString(),
        tyreVehicleOdometer: json["tyre_vehicle_odometer"].toString(),
        tyreAxelId: json["tyre_axel_id"].toString(),
        tyrePosition: json["tyre_position"].toString(),
        tyreDismountReasion: json["tyre_dismount_reasion"].toString() == "null"
            ? "null"
            : json["tyre_dismount_reasion"].toString(),
        tyreStatus: json["tyre_status"].toString(),
        createdAt: DateTime.parse(json["created_at"].toString()),
        updatedAt: DateTime.parse(json["updated_at"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tyre_store_id": tyreStoreId == null ? null : tyreStoreId,
        "tyre_size_id": tyreSizeId,
        "tyre_model_id": tyreModelId,
        "tyre_weight": tyreWeight,
        "tyre_width": tyreWidth,
        "tyre_brand_id": tyreBrandId,
        "tyre_tread_pattern_id": tyreTreadPatternId,
        "tread_depth": treadDepth,
        "tyre_specification_id": tyreSpecificationId,
        "tyre_vendor_id": tyreVendorId,
        "tyre_purchase_date":
            "${tyrePurchaseDate?.year.toString().padLeft(4, '0')}-${tyrePurchaseDate?.month.toString().padLeft(2, '0')}-${tyrePurchaseDate?.day.toString().padLeft(2, '0')}",
        "tyre_warranty_period": tyreWarrantyPeriod,
        "tyre_warranty_expire_date":
            "${tyreWarrantyExpireDate?.year.toString().padLeft(4, '0')}-${tyreWarrantyExpireDate?.month.toString().padLeft(2, '0')}-${tyreWarrantyExpireDate?.day.toString().padLeft(2, '0')}",
        "tyre_warranty_kms": tyreWarrantyKms,
        "tyre_image": tyreImage,
        "tyre_psi": tyrePsi,
        "tyre_deploy_on": tyreDeployOn,
        "tyre_vehicle_id": tyreVehicleId,
        "tyre_vehicle_odometer": tyreVehicleOdometer,
        "tyre_axel_id": tyreAxelId,
        "tyre_position": tyrePosition,
        "tyre_dismount_reasion":
            tyreDismountReasion == null ? null : tyreDismountReasion,
        "tyre_status": tyreStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
