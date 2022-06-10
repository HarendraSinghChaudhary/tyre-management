
class DriverModel {
  DriverModel({
    this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.signupRole,
    this.addressOne,
    this.addressTwo,
    this.countryCode,
    this.phoneNumber,
    this.role,
    this.emailVerifiedAt,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
    this.companyId,
    this.userId,
    this.userRole,
    this.active,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? signupRole;
  String? addressOne;
  String? addressTwo;
  String? countryCode;
  String? phoneNumber;
  String? role;
  dynamic emailVerifiedAt;
  String? email;
  dynamic createdAt;
  dynamic updatedAt;
  int? creatorId;
  int? companyId;
  int? userId;
  String? userRole;
  int? active;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    signupRole: json["signup_role"],
    addressOne: json["address_one"],
    addressTwo: json["address_two"],
    countryCode: json["country_code"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    emailVerifiedAt: json["email_verified_at"],
    email: json["email"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    creatorId: json["creator_id"],
    companyId: json["company_id"],
    userId: json["user_id"],
    userRole: json["user_role"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "signup_role": signupRole,
    "address_one": addressOne,
    "address_two": addressTwo,
    "country_code": countryCode,
    "phone_number": phoneNumber,
    "role": role,
    "email_verified_at": emailVerifiedAt,
    "email": email,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "creator_id": creatorId,
    "company_id": companyId,
    "user_id": userId,
    "user_role": userRole,
    "active": active,
  };
}
