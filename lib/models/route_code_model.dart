
class RouteCodeModel {
  RouteCodeModel({
    this.id,
    this.routeCode,
    this.distance,
    this.creatorId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? routeCode;
  String? distance;
  int? creatorId;
  dynamic createdAt;
  dynamic updatedAt;

  factory RouteCodeModel.fromJson(Map<String, dynamic> json) => RouteCodeModel(
    id: json["id"],
    routeCode: json["Route_Code"],
    distance: json["Distance"],
    creatorId: json["creator_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Route_Code": routeCode,
    "Distance": distance,
    "creator_id": creatorId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
