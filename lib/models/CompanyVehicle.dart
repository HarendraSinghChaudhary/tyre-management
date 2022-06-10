class CompanyVehicle {
  List<Vehicle>? data=List.empty(growable: true);

  CompanyVehicle({this.data});

  CompanyVehicle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Vehicle>[];
      json['data'].forEach((v) {
        data!.add(new Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicle {
  int? id;
  int? companyId;
  String? regNumber;
  int? creatorId;
  Null? model;
  String? createdAt;
  String? updatedAt;

  Vehicle(
      {this.id,
      this.companyId,
      this.regNumber,
      this.creatorId,
      this.model,
      this.createdAt,
      this.updatedAt});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    regNumber = json['reg_number'];
    creatorId = json['creator_id'];
    model = json['model'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['reg_number'] = this.regNumber;
    data['creator_id'] = this.creatorId;
    data['model'] = this.model;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
