class SocialLogin {
  int? id;
  int? userId;
  String? social;
  String? accountId;
  String? socialToken;
  String? createdAt;
  String? updatedAt;

  SocialLogin(
      {this.id,
      this.userId,
      this.social,
      this.accountId,
      this.socialToken,
      this.createdAt,
      this.updatedAt});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    social = json['social'];
    accountId = json['account_id'];
    socialToken = json['social_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['social'] = this.social;
    data['account_id'] = this.accountId;
    data['social_token'] = this.socialToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
   Map<String, dynamic> toLinkJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.socialToken;
    data['company'] = this.social;
    data['accountId'] = this.accountId;
  data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
/***
 * {
    "token": "ya29.A0ARrdaM996hG1khFDyBQT_WYh8gnBIQhjXPBoneumBm_Zrub79rQcT3FuBRaoS8HAnoeN8jubl_rSBDdpNEuEOvq0TT00Pj692xgVRr0vX6FNODFdhL9Wxf77Qg-kSs6EkmbG9KoUuQwKV3T2xcErKYjbMX5w",
    "email": "marsprogrammer0@gmail.com",
    "company": "Google",
    "accountId": "106125316328489133696",
    "user_id":"david"
}
 */