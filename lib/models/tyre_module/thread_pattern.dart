class ThreadPattern {
  ThreadPattern({
    this.id,
    this.treadPatternName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? treadPatternName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ThreadPattern.fromJson(Map<String, dynamic> json) => ThreadPattern(
    id: json["id"],
    treadPatternName: json["tread_pattern_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tread_pattern_name": treadPatternName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
