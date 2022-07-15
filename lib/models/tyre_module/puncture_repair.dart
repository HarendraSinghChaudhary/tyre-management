

class PunctureTyreRepairModel {
  PunctureTyreRepairModel({
    this.id,
    this.repair_option,

  });

  int? id;
  String? repair_option;


  factory PunctureTyreRepairModel.fromJson(Map<String, dynamic> json) => PunctureTyreRepairModel(
    id: json["id"],
   repair_option: json["repair_option"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "repair_option": repair_option,
  
  };
}