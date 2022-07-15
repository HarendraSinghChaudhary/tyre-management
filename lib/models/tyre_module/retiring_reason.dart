



class RetiringReasonModel {
  RetiringReasonModel({
    this.id,
    this.reason,

  });

  int? id;
  String? reason;


  factory RetiringReasonModel.fromJson(Map<String, dynamic> json) => RetiringReasonModel(
    id: json["id"],
   reason: json["reason"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  
  };
}