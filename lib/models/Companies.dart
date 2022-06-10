class Companies {
  List<Company>? data;

  Companies({this.data});

  Companies.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Company>[];
      json['data'].forEach((v) {
        data!.add(new Company.fromJson(v));
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

class Company {
  int? id;
  String? name;
  String? physicalAddress;
  String? phone;
  String? email;
  String? companyRegNumber;
  int? creatorId;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  Company(
      {this.id,
      this.name,
      this.physicalAddress,
      this.phone,
      this.email,
      this.companyRegNumber,
      this.creatorId,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    physicalAddress = json['physicalAddress'];
    phone = json['phone'];
    email = json['email'];
    companyRegNumber = json['company_reg_number'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['physicalAddress'] = this.physicalAddress;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['company_reg_number'] = this.companyRegNumber;
    data['creator_id'] = this.creatorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}
