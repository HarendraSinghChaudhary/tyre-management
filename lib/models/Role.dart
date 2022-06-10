class Role {
  int? creatorId;
  int? companyId;
  int? userId;
  String? userRole;
  int? active;
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
    creatorId = json['creator_id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    userRole = json['user_role'];
    active = json['active'];
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



