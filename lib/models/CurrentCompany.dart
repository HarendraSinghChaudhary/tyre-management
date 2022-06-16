
class CurrentCompany {
  int? id;
  String? name;
  String? physicalAddress;
  String? phone;
  String? email;
  String? companyRegNumber;
  String? creatorId;
  String? createdAt;
  String? updatedAt;

  CurrentCompany(
      {this.id,
      this.name,
      this.physicalAddress,
      this.phone,
      this.email,
      this.companyRegNumber,
      this.creatorId,
      this.createdAt,
      this.updatedAt});

  CurrentCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    physicalAddress = json['physicalAddress'];
    phone = json['phone'];
    email = json['email'];
    companyRegNumber = json['company_reg_number'];
    creatorId = json['creator_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
