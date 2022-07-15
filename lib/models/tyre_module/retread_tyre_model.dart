


class RetreadTyreModel {
  RetreadTyreModel({
    this.id,
    this.tyre_serial_number,
    this.tyre_psi,
    this.tread_depth,
    this.retreads_status
 
  });

 int? id;
  String? tyre_serial_number, tyre_psi, tread_depth;
  String? retreads_status;


  factory RetreadTyreModel.fromJson(Map<String, dynamic> json) => RetreadTyreModel(
    id: json["id"],
    tyre_serial_number: json["tyre_serial_number"],
    tyre_psi: json["tyre_psi"],
    tread_depth: json["tread_depth"],
    retreads_status: json["retreads_status"].toString()
  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tyre_serial_number": tyre_serial_number,
    "tyre_psi": tyre_psi,
    "tread_depth": tread_depth,
    "retreads_status": retreads_status
   
  };
}