// ignore_for_file: prefer_collection_literals

import 'package:PrimeMetrics/controllers/auth/auth_controller.dart';
import 'package:PrimeMetrics/utils/constants.dart';

import '../utils/store.dart';
import 'CurrentCompany.dart';
import 'Role.dart';
import 'SocialLogin.dart';

class UserInfo {
  Data? data;

  UserInfo({this.data});

  UserInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? company;
  CurrentCompany? currentCompany;
  String? countryCode;
  Role? role;
  String? signupRole;
  String? email;
  String? phoneNumber;
  String? addressTwo;
  String? addressOne;
  Fleets? fleets;
  List<SocialLogin>? socialAccounts;
  List<String>? modules;
  String? token;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
     // this.company,
      this.currentCompany,
      this.countryCode,
      this.role,
      this.signupRole,
      this.email,
      this.phoneNumber,
      this.addressTwo,
      this.addressOne,
      this.fleets,
      this.socialAccounts,
      List<String>? modul,
      this.token,
      this.updatedAt,
      this.createdAt}) {
    if (modul == null) {
      this.modules = List.empty(growable: true);
    }
    if (fleets == null) {
      this.fleets = Fleets();
    }
    if (socialAccounts == null) {
      this.socialAccounts = List.empty(growable: true);
    }
    if (role == null) {
      this.role = Role();
    }
  }

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
   // company = json['company'];
    if (json['current_company'] != null) {
      print(json['current_company']);
      currentCompany = new CurrentCompany.fromJson(json['current_company']);
    }
    countryCode = json['country_code'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    signupRole = json['signup_role'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    addressTwo = json['address_two'];
    addressOne = json['address_one'];
    if (json['fleets'] != null) {
      fleets = Fleets.fromJson(json['fleets']);
    } else {
      fleets = Fleets();
    }

    if (json['social_accounts'] != null) {
      socialAccounts = <SocialLogin>[];
      json['social_accounts'].forEach((v) {
        socialAccounts!.add(new SocialLogin.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = json['modules'].cast<String>();
    }
    fleets =
        json['fleets'] != null ? new Fleets.fromJson(json['fleets']) : null;
    token = json['token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
   // data['company'] = this.company;
    if (this.currentCompany != null) {
      data['current_company'] = this.currentCompany?.toJson();
    }
    data['country_code'] = this.countryCode;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['signup_role'] = this.signupRole;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address_two'] = this.addressTwo;
    data['address_one'] = this.addressOne;
    data['fleets'] = this.fleets;

    if (this.socialAccounts != null) {
      data['social_accounts'] =
          this.socialAccounts!.map((v) => v.toJson()).toList();
    }
    if (this.modules != null) {
      data['modules'] = modules;
    }
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }

  getUserRegInfoFormart() {
    return {
      "first_name": this.firstName,
      "last_name": this.lastName,
      "address_two": this.addressTwo,
      "address_one": this.addressOne,
      "company": this.company,
      "country_code": this.countryCode,
      "role": this.role?.userRole,
      "modules": this.modules?.toList(),
      "email": this.email,
      "signup_role": this.signupRole,
      "password": getPassword(),
      "rigid": this.fleets?.rigid ?? 0,
      "artic": this.fleets?.artic ?? 0,
      "drawbar": this.fleets?.drawbar ?? 0,
      "interlink": this.fleets?.interlink ?? 0,
      "phone_number": this.phoneNumber,
      "secret_code": getSecret()
    };
  }

  getUserRegInfoFormartSocial() {
    var social = AuthController.social;
    return {
      "first_name": this.firstName,
      "last_name": this.lastName,
      "address_two": this.addressTwo,
      "address_one": this.addressOne,
     "company": this.company,
      "country_code": this.countryCode,
      "role": this.role?.userRole,
      "modules": this.modules?.toList(),

      "signup_role": this.signupRole,
      //"password": store.read("password"),
      "rigid": this.fleets?.rigid ?? 0,
      "artic": this.fleets?.artic ?? 0,
      "drawbar": this.fleets?.drawbar ?? 0,
      "interlink": this.fleets?.interlink ?? 0,
      "phone_number": this.phoneNumber,
      'social': social?.social,

      //  "secret_code": store.read("secret"),
      "social_token": social?.socialToken
    };
  }
}

// class UserInfo {
//   Data? data = Data();

//   UserInfo({Data? data}) {
//     if (data == null) {
//       this.data = Data();
//     }
//   }

//   UserInfo.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? company;
//   String? countryCode;
//   String? role;
//   String? signupRole;
//   String? email;
//   String? phoneNumber;
//   String? addressTwo;
//   String? addressOne;
//   Fleets? fleets;
//   List<String>? modules;
//   List<SocialLogin>? socialAccounts;

//   String? token;
//   String? updatedAt;
//   String? createdAt;

//   Data(
//       {this.id,
//       this.firstName,
//       this.lastName,
//       this.company,
//       this.countryCode,
//       this.role,
//       this.signupRole,
//       this.email,
//       this.phoneNumber,
//       this.addressTwo,
//       this.addressOne,
//       Fleets? fleets,
//       List<String>? modul,
//       List<SocialLogin>? socialAccounts,
//       this.token,
//       this.updatedAt,
//       this.createdAt}) {
//     if (modul == null) {
//       this.modules = List.empty(growable: true);
//     }
//     if (fleets == null) {
//       this.fleets = Fleets();
//     }
//     if (socialAccounts == null) {
//       this.socialAccounts = List.empty(growable: true);
//     }
//   }

//   getUserRegInfoFormart() {
//     return {
//       "first_name": this.firstName,
//       "last_name": this.lastName,
//       "address_two": this.addressTwo,
//       "address_one": this.addressOne,
//       "company": this.company,
//       "country_code": this.countryCode,
//       "role": this.role,
//       "modules": this.modules?.toList(),
//       "email": this.email,
//       "signup_role": this.signupRole,
//       "password": store.read("password"),
//       "rigid": this.fleets?.rigid ?? 0,
//       "artic": this.fleets?.artic ?? 0,
//       "drawbar": this.fleets?.drawbar ?? 0,
//       "interlink": this.fleets?.interlink ?? 0,
//       "phone_number": this.phoneNumber,
//       "secret_code": store.read("secret")
//     };
//   }

//   getUserRegInfoFormartSocial() {
//     var social = AuthController.social;
//     return {
//       "first_name": this.firstName,
//       "last_name": this.lastName,
//       "address_two": this.addressTwo,
//       "address_one": this.addressOne,
//       "company": this.company,
//       "country_code": this.countryCode,
//       "role": this.role,
//       "modules": this.modules?.toList(),

//       "signup_role": this.signupRole,
//       //"password": store.read("password"),
//       "rigid": this.fleets?.rigid ?? 0,
//       "artic": this.fleets?.artic ?? 0,
//       "drawbar": this.fleets?.drawbar ?? 0,
//       "interlink": this.fleets?.interlink ?? 0,
//       "phone_number": this.phoneNumber,
//       'social':social?.social,

//       //  "secret_code": store.read("secret"),
//       "social_token": social?.socialToken
//     };
//   }

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     company = json['company'];
//     countryCode = json['country_code'];
//     role = json['role'];
//     signupRole = json['signup_role'];
//     email = json['email'];
//     phoneNumber = json['phone_number'];
//     addressTwo = json['address_two'];
//     addressOne = json['address_one'];
//     if (json['social_accounts'] != null) {
//       socialAccounts = <SocialLogin>[];
//       json['social_accounts'].forEach((v) {
//         socialAccounts!.add(new SocialLogin.fromJson(v));
//       });
//     }
//     fleets =
//         json['fleets'] != null ? new Fleets.fromJson(json['fleets']) : null;
//     modules = json['modules'].cast<String>();

//     token = json['token'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['company'] = this.company;
//     data['country_code'] = this.countryCode;
//     data['role'] = this.role;
//     data['signup_role'] = this.signupRole;
//     data['email'] = this.email;
//     data['phone_number'] = this.phoneNumber;
//     data['address_two'] = this.addressTwo;
//     data['address_one'] = this.addressOne;
//     if (this.fleets != null) {
//       data['fleets'] = this.fleets!.toJson();
//     }
//     if (this.socialAccounts != null) {
//       data['social_accounts'] =
//           this.socialAccounts!.map((v) => v.toJson()).toList();
//     }

//     data['modules'] = this.modules;
//     data['token'] = this.token;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

class Fleets {
  int? id;
  int? userId;
  int? rigid;
  int? artic;
  int? drawbar;
  int? interlink;
  String? createdAt;
  String? updatedAt;

  Fleets(
      {this.id,
      this.userId,
      this.rigid,
      this.artic,
      this.drawbar,
      this.interlink,
      this.createdAt,
      this.updatedAt});

  Fleets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rigid = json['rigid'];
    artic = json['artic'];
    drawbar = json['drawbar'];
    interlink = json['interlink'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['rigid'] = this.rigid;
    data['artic'] = this.artic;
    data['drawbar'] = this.drawbar;
    data['interlink'] = this.interlink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
