class TripData {
  Trip? data;

  TripData({this.data});

  TripData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Trip.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Trip {
  String? duration;
  String? route;
  int? refuels;
  int? id;

  String? startOdometer;
  String? startedAt;
  String? endedAt;
  String? endOdometer;
  bool? isActive;
  int? closingFuel;
  String? lat;
  String? long;
  String? startFuel;
  String? image;
  String? customerName;
  Commodities? commodities;
  String? signatureImg;
  Commodities? town;
  Service? service;
  List<Intermediary>? intermediary;

  Trip(
      {this.duration,
      this.route,
      this.refuels,
      this.startOdometer,
      this.startedAt,
      this.endedAt,
      this.endOdometer,
      this.isActive,
      this.closingFuel,
      this.lat,
      this.id,
      this.long,
      this.startFuel,
      this.image,
      this.customerName,
      this.commodities,
      this.signatureImg,
      this.town,
      this.service,
      this.intermediary});

  Trip.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    route = json['route'];
    id = json['id'];
    refuels = json['refuels'];
    startOdometer = json['start_odometer'];
    startedAt = json['started_at'];
    endedAt = json['ended_at'];
    endOdometer = json['end_odometer'];
    isActive = json['is_active'];
    closingFuel = json['closing_fuel'];
    lat = json['lat'];
    long = json['long'];
    startFuel = json['start_fuel'];
    image = json['image'];
    customerName = json['customer_name'];
    commodities = json['commodities'] != null
        ? new Commodities.fromJson(json['commodities'])
        : null;
    signatureImg = json['signature_img'];
    town = json['town'] != null ? new Commodities.fromJson(json['town']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['intermediary'] != null) {
      intermediary = <Intermediary>[];
      json['intermediary'].forEach((v) {
        intermediary!.add(new Intermediary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['route'] = this.route;
    data['id'] = this.id;
    data['refuels'] = this.refuels;
    data['start_odometer'] = this.startOdometer;
    data['started_at'] = this.startedAt;
    data['ended_at'] = this.endedAt;
    data['end_odometer'] = this.endOdometer;
    data['is_active'] = this.isActive;
    data['closing_fuel'] = this.closingFuel;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['start_fuel'] = this.startFuel;
    data['image'] = this.image;
    data['customer_name'] = this.customerName;
    if (this.commodities != null) {
      data['commodities'] = this.commodities!.toJson();
    }
    data['signature_img'] = this.signatureImg;
    if (this.town != null) {
      data['town'] = this.town!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.intermediary != null) {
      data['intermediary'] = this.intermediary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commodities {
  int? id;
  int? creatorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Commodities(
      {this.id, this.creatorId, this.name, this.createdAt, this.updatedAt});

  Commodities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Service {
  String? serviceName;

  Service({this.serviceName});

  Service.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    return data;
  }
}

class Intermediary {
  int? id;
  int? creatorId;
  int? companyId;
  int? townId;
  int? tripId;
  String? commodityId;
  String? refuelStation;
  String? fuelQuantity;
  String? customerName;
  String? odometer;
  int? destination;
  String? fuelObc;
  String? startedOn;
  String? endedAt;
  String? serviceName;
  String? image;
  String? signatureImg;
  String? lat;
  String? long;
  String? createdAt;
  String? updatedAt;
  String? vehicleId;
  String? service;
  Commodities? town;

  Intermediary(
      {this.id,
      this.creatorId,
      this.companyId,
      this.townId,
      this.tripId,
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
      this.vehicleId,
      this.service,
      this.town});

  Intermediary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    companyId = json['company_id'];
    townId = json['town_id'];
    tripId = json['trip_id'];
    commodityId = json['commodity_id'].toString();
    refuelStation = json['refuel_station'];
    fuelQuantity = json['fuel_quantity'].toString();
    customerName = json['customer_name'];
    odometer = json['odometer'];
    destination = json['destination'];
    fuelObc = json['fuel_obc'];
    startedOn = json['startedOn'];
    endedAt = json['endedAt'];
    serviceName = json['service_name'];
    image = json['image'];
    signatureImg = json['signature_img'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vehicleId = json['vehicle_id'];
    service = json['service'];
    town = json['town'] != null ? new Commodities.fromJson(json['town']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['company_id'] = this.companyId;
    data['town_id'] = this.townId;
    data['trip_id'] = this.tripId;
    data['commodity_id'] = this.commodityId;
    data['refuel_station'] = this.refuelStation;
    data['fuel_quantity'] = this.fuelQuantity;
    data['customer_name'] = this.customerName;
    data['odometer'] = this.odometer;
    data['destination'] = this.destination;
    data['fuel_obc'] = this.fuelObc;
    data['startedOn'] = this.startedOn;
    data['endedAt'] = this.endedAt;
    data['service_name'] = this.serviceName;
    data['image'] = this.image;
    data['signature_img'] = this.signatureImg;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vehicle_id'] = this.vehicleId;
    data['service'] = this.service;
    if (this.town != null) {
      data['town'] = this.town!.toJson();
    }
    return data;
  }
}
