

class RecentTripModel {
  RecentTripModel({
    this.driverName,
    this.route,
    this.distance,
    this.duration,
    this.refuels,
    this.id,
    this.startOdometer,
    this.startedAt,
    this.endedAt,
    this.endOdometer,
    this.isActive,
    this.closingFuel,
    this.startFuel,
    this.signatureImg,
    this.town,
    this.service,
    this.intermediary,
    this.lat,
    this.long,
    this.image,
    this.customerName,
    this.commodities,
  });

  String? driverName;
  String? route;
  String? distance;
  String? duration;
  int? refuels;
  int? id;
  String? startOdometer;
  DateTime? startedAt;
  DateTime? endedAt;
  String? endOdometer;
  bool? isActive;
  int? closingFuel;
  String? startFuel;
  String? signatureImg;
  Town? town;
  Service? service;
  List<Intermediary>? intermediary;
  String? lat;
  String? long;
  String? image;
  dynamic customerName;
  dynamic commodities;

  factory RecentTripModel.fromJson(Map<String, dynamic> json) => RecentTripModel(
    driverName: json["driver_name"] == null ? null : json["driver_name"],
    route: json["route"],
    distance: json["distance"],
    duration: json["duration"],
    refuels: json["refuels"],
    id: json["id"],
    startOdometer: json["start_odometer"],
    startedAt: DateTime.parse(json["started_at"]),
    endedAt: json["ended_at"] == null ? null : DateTime.parse(json["ended_at"]),
    endOdometer: json["end_odometer"] == null ? null : json["end_odometer"],
    isActive: json["is_active"],
    closingFuel: json["closing_fuel"],
    startFuel: json["start_fuel"],
    signatureImg: json["signature_img"] == null ? null : json["signature_img"],
    town: Town.fromJson(json["town"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    intermediary: List<Intermediary>.from(json["intermediary"].map((x) => Intermediary.fromJson(x))),
    lat: json["lat"] == null ? null : json["lat"],
    long: json["long"] == null ? null : json["long"],
    image: json["image"] == null ? null : json["image"],
    customerName: json["customer_name"],
    commodities: json["commodities"],
  );

  Map<String, dynamic> toJson() => {
    "driver_name": driverName == null ? null : driverName,
    "route": route,
    "distance": distance,
    "duration": duration,
    "refuels": refuels,
    "id": id,
    "start_odometer": startOdometer,
    "started_at": startedAt?.toIso8601String(),
    "ended_at": endedAt == null ? null : endedAt?.toIso8601String(),
    "end_odometer": endOdometer == null ? null : endOdometer,
    "is_active": isActive,
    "closing_fuel": closingFuel,
    "start_fuel": startFuel,
    "signature_img": signatureImg == null ? null : signatureImg,
    "town": town?.toJson(),
    "service": service == null ? null : service?.toJson(),
    "intermediary": List<dynamic>.from(intermediary!.map((x) => x.toJson())),
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
    "image": image == null ? null : image,
    "customer_name": customerName,
    "commodities": commodities,
  };
}

class Intermediary {
  Intermediary({
    this.id,
    this.creatorId,
    this.companyId,
    this.townId,
    this.tripId,
    this.vehicleId,
    this.commodityId,
    this.refuelStation,
    this.fuelQuantity,
    this.customerName,
    this.odometer,
    this.destination,
    this.fuelObc,
    this.startedOn,
    this.endedAt,
    this.serviceName,
    this.image,
    this.signatureImg,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.town,
  });

  int? id;
  int? creatorId;
  int? companyId;
  int? townId;
  int? tripId;
  dynamic vehicleId;
  int? commodityId;
  dynamic refuelStation;
  dynamic fuelQuantity;
  String? customerName;
  String? odometer;
  int? destination;
  String? fuelObc;
  DateTime? startedOn;
  DateTime? endedAt;
  String? serviceName;
  String? image;
  dynamic signatureImg;
  String? lat;
  String? long;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic service;
  Town? town;

  factory Intermediary.fromJson(Map<String, dynamic> json) => Intermediary(
    id: json["id"],
    creatorId: json["creator_id"],
    companyId: json["company_id"],
    townId: json["town_id"],
    tripId: json["trip_id"],
    vehicleId: json["vehicle_id"],
    commodityId: json["commodity_id"] == null ? null : json["commodity_id"],
    refuelStation: json["refuel_station"],
    fuelQuantity: json["fuel_quantity"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    odometer: json["odometer"],
    destination: json["destination"],
    fuelObc: json["fuel_obc"],
    startedOn: json["startedOn"] == null ? null : DateTime.parse(json["startedOn"]),
    endedAt: json["endedAt"] == null ? null : DateTime.parse(json["endedAt"]),
    serviceName: json["service_name"],
    image: json["image"] == null ? null : json["image"],
    signatureImg: json["signature_img"],
    lat: json["lat"],
    long: json["long"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    service: json["service"],
    town: Town.fromJson(json["town"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creator_id": creatorId,
    "company_id": companyId,
    "town_id": townId,
    "trip_id": tripId,
    "vehicle_id": vehicleId,
    "commodity_id": commodityId == null ? null : commodityId,
    "refuel_station": refuelStation,
    "fuel_quantity": fuelQuantity,
    "customer_name": customerName == null ? null : customerName,
    "odometer": odometer,
    "destination": destination,
    "fuel_obc": fuelObc,
    "startedOn": startedOn == null ? null : startedOn?.toIso8601String(),
    "endedAt": endedAt == null ? null : endedAt?.toIso8601String(),
    "service_name": serviceName,
    "image": image == null ? null : image,
    "signature_img": signatureImg,
    "lat": lat,
    "long": long,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service": service,
    "town": town?.toJson(),
  };
}

class Town {
  Town({
    this.id,
    this.name,
    this.creatorId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? creatorId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    id: json["id"],
    name: json["name"],
    creatorId: json["creator_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Service {
  Service({
    this.serviceName,
  });

  String? serviceName;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceName: json["service_name"],
  );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
  };
}
