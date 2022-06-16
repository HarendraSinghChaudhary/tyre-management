class Role {
  String? creatorId;
  String? companyId;
  String? userId;
  String? userRole;
  String? active;
  int? id;
  String? createdAt;
  String? updatedAt;

  Role(
      {this.creatorId,
      this.companyId,
      this.userId,
      this.userRole,
      this.active,
      this.id,
      this.createdAt,
      this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    creatorId = json['creator_id'].toString();
    companyId = json['company_id'].toString();
    userId = json['user_id'].toString();
    userRole = json['user_role'];
    active = json['active'].toString();
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator_id'] = this.creatorId;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['user_role'] = this.userRole;
    data['active'] = this.active;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



