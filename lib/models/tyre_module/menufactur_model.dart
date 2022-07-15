


class MenufactureModel {
  MenufactureModel({
    this.id,
    this.name,
    this.physicalAddress,
    this.company_reg_number,
  
  });

  String? id;
  String? name;
  String? physicalAddress;
  String? company_reg_number;
 

  factory MenufactureModel.fromJson(Map<String, dynamic> json) => MenufactureModel(
    id: json["id"].toString(),
    name: json["name"],
    physicalAddress: json["physicalAddress"],
    company_reg_number: json["company_reg_number"],
   
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "physicalAddress": physicalAddress,
    "created_at": company_reg_number,
   
  };
}