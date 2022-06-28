


class DismountReason {
  DismountReason({
    this.id,
    this.dismountResion,

  });

  String? id;
  String? dismountResion;


  factory DismountReason.fromJson(Map<String, dynamic> json) => DismountReason(
    id: json["id"],
    dismountResion: json["dismountResion"],
  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dismountResion": dismountResion,
 
  };
}
