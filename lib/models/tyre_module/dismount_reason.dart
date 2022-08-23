


class DismountReason {
  DismountReason({
    this.id,
    this.dismount_reason,

  });

  String? id;
  String? dismount_reason;


  factory DismountReason.fromJson(Map<String, dynamic> json) => DismountReason(
    id: json["id"].toString(),
    dismount_reason: json["dismount_reason"].toString(),
  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dismount_reason": dismount_reason,
 
  };
}
