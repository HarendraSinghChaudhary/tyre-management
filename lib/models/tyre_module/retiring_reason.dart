



class RetiringReasonModel {
  RetiringReasonModel({
    this.id,
    this.reason,

  });

  String? id;
  String? reason;


  factory RetiringReasonModel.fromJson(Map<String, dynamic> json) => RetiringReasonModel(
    id: json["id"].toString(),
   reason: json["reason"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "reason": reason,
  
  };
}