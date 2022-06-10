class CompanyTown {
  int? id;
  String? name;
  int? creatorId;
  String? createdAt;
  String? updatedAt;

  CompanyTown(
      {this.id, this.name, this.creatorId, this.createdAt, this.updatedAt});

  CompanyTown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['creator_id'] = this.creatorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}