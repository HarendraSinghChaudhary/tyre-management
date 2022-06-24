// To parse this JSON data, do
//
//     final tyreSerialNumer = tyreSerialNumerFromJson(jsonString);

import 'dart:convert';

// TyreSerialNumer tyreSerialNumerFromJson(String str) => TyreSerialNumer.fromJson(json.decode(str));

// String tyreSerialNumerToJson(TyreSerialNumer data) => json.encode(data.toJson());

// class TyreSerialNumer {
//     TyreSerialNumer({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     bool status;
//     String message;
//     List<Datum> data;

//     factory TyreSerialNumer.fromJson(Map<String, dynamic> json) => TyreSerialNumer(
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     Datum({
//         this.id,
//         this.tyreSerialNumber,
//         this.tyreStoreId,
//         this.tyreSizeId,
//         this.tyreModelId,
//         this.tyreWeight,
//         this.tyreWidth,
//         this.tyreBrandId,
//         this.tyreTreadPatternId,
//         this.treadDepth,
//         this.tyreSpecificationId,
//         this.tyreVendorId,
//         this.tyrePurchaseDate,
//         this.tyreWarrantyPeriod,
//         this.tyreWarrantyExpireDate,
//         this.tyreWarrantyKms,
//         this.tyreImage,
//         this.tyrePsi,
//         this.tyreDeployOn,
//         this.tyreVehicleId,
//         this.tyreVehicleOdometer,
//         this.tyreAxelId,
//         this.tyrePosition,
//         this.tyreDismountReasion,
//         this.isPuncture,
//         this.tyrePunctureRepairId,
//         this.tyreDefect,
//         this.inspectionNote,
//         this.tyreStatus,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int? id;
//     String? tyreSerialNumber;
//     String? tyreStoreId;
//     String? tyreSizeId;
//     String? tyreModelId;
//     String? tyreWeight;
//     String? tyreWidth;
//     String? tyreBrandId;
//     String? tyreTreadPatternId;
//     String? treadDepth;
//     String? tyreSpecificationId;
//     String? tyreVendorId;
//     DateTime? tyrePurchaseDate;
//     String? tyreWarrantyPeriod;
//     DateTime? tyreWarrantyExpireDate;
//     String? tyreWarrantyKms;
//     String? tyreImage;
//     String? tyrePsi;
//     dynamic tyreDeployOn;
//     dynamic tyreVehicleId;
//     dynamic tyreVehicleOdometer;
//     dynamic tyreAxelId;
//     dynamic tyrePosition;
//     dynamic tyreDismountReasion;
//     String? isPuncture;
//     String? tyrePunctureRepairId;
//     String? tyreDefect;
//     String? inspectionNote;
//     String? tyreStatus;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         tyreSerialNumber: json["tyre_serial_number"],
//         tyreStoreId: json["tyre_store_id"] == null ? null : json["tyre_store_id"],
//         tyreSizeId: json["tyre_size_id"],
//         tyreModelId: json["tyre_model_id"],
//         tyreWeight: json["tyre_weight"],
//         tyreWidth: json["tyre_width"],
//         tyreBrandId: json["tyre_brand_id"],
//         tyreTreadPatternId: json["tyre_tread_pattern_id"],
//         treadDepth: json["tread_depth"],
//         tyreSpecificationId: json["tyre_specification_id"],
//         tyreVendorId: json["tyre_vendor_id"],
//         tyrePurchaseDate: DateTime.parse(json["tyre_purchase_date"]),
//         tyreWarrantyPeriod: json["tyre_warranty_period"],
//         tyreWarrantyExpireDate: DateTime.parse(json["tyre_warranty_expire_date"]),
//         tyreWarrantyKms: json["tyre_warranty_kms"],
//         tyreImage: json["tyre_image"],
//         tyrePsi: json["tyre_psi"] == null ? null : json["tyre_psi"],
//         tyreDeployOn: json["tyre_deploy_on"],
//         tyreVehicleId: json["tyre_vehicle_id"],
//         tyreVehicleOdometer: json["tyre_vehicle_odometer"],
//         tyreAxelId: json["tyre_axel_id"],
//         tyrePosition: json["tyre_position"],
//         tyreDismountReasion: json["tyre_dismount_reasion"],
//         isPuncture: json["is_puncture"] == null ? null : json["is_puncture"],
//         tyrePunctureRepairId: json["tyre_puncture_repair_id"] == null ? null : json["tyre_puncture_repair_id"],
//         tyreDefect: json["tyre_defect"] == null ? null : json["tyre_defect"],
//         inspectionNote: json["inspection_note"] == null ? null : json["inspection_note"],
//         tyreStatus: json["tyre_status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "tyre_serial_number": tyreSerialNumber,
//         "tyre_store_id": tyreStoreId == null ? null : tyreStoreId,
//         "tyre_size_id": tyreSizeId,
//         "tyre_model_id": tyreModelId,
//         "tyre_weight": tyreWeight,
//         "tyre_width": tyreWidth,
//         "tyre_brand_id": tyreBrandId,
//         "tyre_tread_pattern_id": tyreTreadPatternId,
//         "tread_depth": treadDepth,
//         "tyre_specification_id": tyreSpecificationId,
//         "tyre_vendor_id": tyreVendorId,
//         "tyre_purchase_date": "${tyrePurchaseDate?.year.toString().padLeft(4, '0')}-${tyrePurchaseDate?.month.toString().padLeft(2, '0')}-${tyrePurchaseDate?.day.toString().padLeft(2, '0')}",
//         "tyre_warranty_period": tyreWarrantyPeriod,
//         "tyre_warranty_expire_date": "${tyreWarrantyExpireDate?.year.toString().padLeft(4, '0')}-${tyreWarrantyExpireDate?.month.toString().padLeft(2, '0')}-${tyreWarrantyExpireDate?.day.toString().padLeft(2, '0')}",
//         "tyre_warranty_kms": tyreWarrantyKms,
//         "tyre_image": tyreImage,
//         "tyre_psi": tyrePsi == null ? null : tyrePsi,
//         "tyre_deploy_on": tyreDeployOn,
//         "tyre_vehicle_id": tyreVehicleId,
//         "tyre_vehicle_odometer": tyreVehicleOdometer,
//         "tyre_axel_id": tyreAxelId,
//         "tyre_position": tyrePosition,
//         "tyre_dismount_reasion": tyreDismountReasion,
//         "is_puncture": isPuncture == null ? null : isPuncture,
//         "tyre_puncture_repair_id": tyrePunctureRepairId == null ? null : tyrePunctureRepairId,
//         "tyre_defect": tyreDefect == null ? null : tyreDefect,
//         "inspection_note": inspectionNote == null ? null : inspectionNote,
//         "tyre_status": tyreStatus,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }



class SerialNumberModel {
  SerialNumberModel({
    this.id,
    this.tyre_serial_number,
    this.tyre_psi,
    this.tread_depth
 
  });

  int? id;
  String? tyre_serial_number, tyre_psi, tread_depth;


  factory SerialNumberModel.fromJson(Map<String, dynamic> json) => SerialNumberModel(
    id: json["id"],
    tyre_serial_number: json["tyre_serial_number"],
    tyre_psi: json["tyre_psi"],
    tread_depth: json["tread_depth"]
  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tyre_serial_number": tyre_serial_number,
    "tyre_psi": tyre_psi,
    "tread_depth": tread_depth
   
  };
}