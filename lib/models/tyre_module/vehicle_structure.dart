

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
  String? tyrePsi;
  String? tyreDeployOn;
  String? tyreVehicleId;
  String? tyreVehicleOdometer;
  String? tyreAxelId;
  String? tyrePosition;
  String? tyreDismountReasion;
  String? tyreStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MountedTyre.fromJson(Map<String, dynamic> json) => MountedTyre(
    id: json["id"],
    tyreStoreId: json["tyre_store_id"].toString(),
    tyreSizeId: json["tyre_size_id"].toString(),
    tyreModelId: json["tyre_model_id"].toString(),
    tyreWeight: json["tyre_weight"].toString(),
    tyreWidth: json["tyre_width"].toString(),
    tyreBrandId: json["tyre_brand_id"].toString(),
    tyreTreadPatternId: json["tyre_tread_pattern_id"].toString(),
    treadDepth: json["tread_depth"].toString(),
    tyreSpecificationId: json["tyre_specification_id"].toString(),
    tyreVendorId: json["tyre_vendor_id"].toString(),
    tyrePurchaseDate: DateTime.parse(json["tyre_purchase_date"]),
    tyreWarrantyPeriod: json["tyre_warranty_period"].toString(),
    tyreWarrantyExpireDate: DateTime.parse(json["tyre_warranty_expire_date"]),
    tyreWarrantyKms: json["tyre_warranty_kms"].toString(),
    tyreImage: json["tyre_image"].toString(),
    tyrePsi: json["tyre_psi"].toString(),
    tyreDeployOn: json["tyre_deploy_on"].toString(),
    tyreVehicleId: json["tyre_vehicle_id"].toString(),
    tyreVehicleOdometer: json["tyre_vehicle_odometer"].toString(),
    tyreAxelId: json["tyre_axel_id"].toString(),
    tyrePosition: json["tyre_position"].toString(),
    tyreDismountReasion: json["tyre_dismount_reasion"].toString(),
    tyreStatus: json["tyre_status"].toString(),
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
    this.tyre_serial_number,
    this.tread_depth,
    this.tyre_psi,
    this.tyre_axel_id,
    this.tyre_position,
    this.tyre_size_id,
    this.size_name,
    this.recom_psi,
    this.max_psi,
    this.axcelOrder,
    this.noOfTyres,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? vehicleId;
  String? axcelOrder;
  String? noOfTyres;
  String? tread_depth;
  String? tyre_psi;
  String? tyre_axel_id;
  String? tyre_position;
  String? tyre_size_id;
  String? size_name;
  String? recom_psi;
  String? max_psi;
  String? tyre_serial_number;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory VehecleStructure.fromJson(Map<String, dynamic> json) => VehecleStructure(
    id: json["id"],
    vehicleId: json["vehicle_id"].toString(),
    axcelOrder: json["axcel_order"].toString(),
    noOfTyres: json["no_of_tyres"].toString(),
    tread_depth: json["tread_depth"].toString(),
    tyre_psi: json["tyre_psi"].toString(),
    tyre_axel_id: json["tyre_axel_id"].toString(),
    tyre_position: json["tyre_position"].toString(),
    tyre_size_id: json["tyre_size_id"].toString(),
    size_name: json ["size_name"].toString(),
    recom_psi: json ["recom_psi"].toString(),
    max_psi: json['max_psi'].toString(),
    tyre_serial_number: json["tyre_serial_number"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_id": vehicleId,
    "axcel_order": axcelOrder,
    "no_of_tyres": noOfTyres,
    "tread_depth": tread_depth,
    "tyre_psi": tyre_psi,
    "tyre_axel_id": tyre_axel_id,
    "tyre_position": tyre_position,
    "tyre_size_id" : tyre_size_id,
    "tyre_serial_number": tyre_serial_number,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "size_name": size_name.toString(),
    "recom_psi": recom_psi.toString(),
    "max_psi": max_psi.toString()
  };
}
