class CompanyCommodity {
  List<Commodity>? data=List.empty(growable: true);

  CompanyCommodity({this.data});

  CompanyCommodity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Commodity>[];
      json['data'].forEach((v) {
        data!.add(new Commodity.fromJson(v));
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

class Commodity {
  int? id;
  int? creatorId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  Commodity(
      {this.id,
      this.creatorId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  Commodity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}
