

class VehicleStructure {
  VehicleStructure({
    this.vehecleStructure,
    this.tyres,
  });

  List<VehecleStructure>? vehecleStructure;
  List<MountedTyre>? tyres;

  factory VehicleStructure.fromJson(Map<String, dynamic> json) => VehicleStructure(
    vehecleStructure: List<VehecleStructure>.from(json["vehecleStructure"].map((x) => VehecleStructure.fromJson(x))),
    tyres: List<MountedTyre>.from(json["tyres"].map((x) => MountedTyre.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vehecleStructure": List<dynamic>.from(vehecleStructure?.map((x) => x.toJson())??[]),
    "tyres": List<dynamic>.from(tyres?.map((x) => x.toJson())??[]),
  };
}

class MountedTyre {
  MountedTyre({
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
  dynamic tyreStoreId;
  int? tyreSizeId;
  int? tyreModelId;
  String? tyreWeight;
  String? tyreWidth;
  int? tyreBrandId;
  int? tyreTreadPatternId;
  String? treadDepth;
  int? tyreSpecificationId;
  int? tyreVendorId;
  DateTime? tyrePurchaseDate;
  String? tyreWarrantyPeriod;
  DateTime? tyreWarrantyExpireDate;
  String? tyreWarrantyKms;
  String? tyreImage;
  String? tyrePsi;
  String? tyreDeployOn;
  int? tyreVehicleId;
  String? tyreVehicleOdometer;
  int? tyreAxelId;
  String? tyrePosition;
  String? tyreDismountReasion;
  int? tyreStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MountedTyre.fromJson(Map<String, dynamic> json) => MountedTyre(
    id: json["id"],
    tyreStoreId: json["tyre_store_id"],
    tyreSizeId: json["tyre_size_id"],
    tyreModelId: json["tyre_model_id"],
    tyreWeight: json["tyre_weight"],
    tyreWidth: json["tyre_width"],
    tyreBrandId: json["tyre_brand_id"],
    tyreTreadPatternId: json["tyre_tread_pattern_id"],
    treadDepth: json["tread_depth"],
    tyreSpecificationId: json["tyre_specification_id"],
    tyreVendorId: json["tyre_vendor_id"],
    tyrePurchaseDate: DateTime.parse(json["tyre_purchase_date"]),
    tyreWarrantyPeriod: json["tyre_warranty_period"],
    tyreWarrantyExpireDate: DateTime.parse(json["tyre_warranty_expire_date"]),
    tyreWarrantyKms: json["tyre_warranty_kms"],
    tyreImage: json["tyre_image"],
    tyrePsi: json["tyre_psi"],
    tyreDeployOn: json["tyre_deploy_on"],
    tyreVehicleId: json["tyre_vehicle_id"],
    tyreVehicleOdometer: json["tyre_vehicle_odometer"],
    tyreAxelId: json["tyre_axel_id"],
    tyrePosition: json["tyre_position"],
    tyreDismountReasion: json["tyre_dismount_reasion"],
    tyreStatus: json["tyre_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tyre_store_id": tyreStoreId,
    "tyre_size_id": tyreSizeId,
    "tyre_model_id": tyreModelId,
    "tyre_weight": tyreWeight,
    "tyre_width": tyreWidth,
    "tyre_brand_id": tyreBrandId,
    "tyre_tread_pattern_id": tyreTreadPatternId,
    "tread_depth": treadDepth,
    "tyre_specification_id": tyreSpecificationId,
    "tyre_vendor_id": tyreVendorId,
    "tyre_purchase_date": "${tyrePurchaseDate?.year.toString().padLeft(4, '0')}-${tyrePurchaseDate?.month.toString().padLeft(2, '0')}-${tyrePurchaseDate?.day.toString().padLeft(2, '0')}",
    "tyre_warranty_period": tyreWarrantyPeriod,
    "tyre_warranty_expire_date": "${tyreWarrantyExpireDate?.year.toString().padLeft(4, '0')}-${tyreWarrantyExpireDate?.month.toString().padLeft(2, '0')}-${tyreWarrantyExpireDate?.day.toString().padLeft(2, '0')}",
    "tyre_warranty_kms": tyreWarrantyKms,
    "tyre_image": tyreImage,
    "tyre_psi": tyrePsi,
    "tyre_deploy_on": tyreDeployOn,
    "tyre_vehicle_id": tyreVehicleId,
    "tyre_vehicle_odometer": tyreVehicleOdometer,
    "tyre_axel_id": tyreAxelId,
    "tyre_position": tyrePosition,
    "tyre_dismount_reasion": tyreDismountReasion,
    "tyre_status": tyreStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class VehecleStructure {
  VehecleStructure({
    this.id,
    this.vehicleId,
    this.axcelOrder,
    this.noOfTyres,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? vehicleId;
  int? axcelOrder;
  int? noOfTyres;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory VehecleStructure.fromJson(Map<String, dynamic> json) => VehecleStructure(
    id: json["id"],
    vehicleId: json["vehicle_id"],
    axcelOrder: json["axcel_order"],
    noOfTyres: json["no_of_tyres"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_id": vehicleId,
    "axcel_order": axcelOrder,
    "no_of_tyres": noOfTyres,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
