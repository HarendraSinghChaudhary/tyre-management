



class DefectModel {
  DefectModel({
    this.id,
    this.defect_type,

  });

  int? id;
  String? defect_type;


  factory DefectModel.fromJson(Map<String, dynamic> json) => DefectModel(
    id: json["id"],
   defect_type: json["defect_type"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "defect_type": defect_type,
  
  };
}