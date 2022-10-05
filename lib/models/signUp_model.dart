// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    SignupModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );
    // SignupModel.fromJson(Map<String, dynamic> json){
    //   SignupModel signupModel = SignupModel();
    //   signupModel.data=Data.fromJson(json["data"]);
    //    status =json["status"];
    //     message = json["message"];
    //    return signupModel;
    // }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.firstName,
        this.lastName,
        this.addressOne,
        this.addressTwo,
        this.signupRole,
        this.email,
        this.company,
        this.countryCode,
        this.role,
        this.phoneNumber,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? firstName;
    String? lastName;
    String? addressOne;
    String? addressTwo;
    String? signupRole;
    String? email;
    String? company;
    String? countryCode;
    String? role;
    String? phoneNumber;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        addressOne: json["address_one"],
        addressTwo: json["address_two"],
        signupRole: json["signup_role"],
        email: json["email"],
        company: json["company"],
        countryCode: json["country_code"],
        role: json["role"],
        phoneNumber: json["phone_number"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_one": addressOne,
        "address_two": addressTwo,
        "signup_role": signupRole,
        "email": email,
        "company": company,
        "country_code": countryCode,
        "role": role,
        "phone_number": phoneNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
