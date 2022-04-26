// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeModel> employeeListModelFromJson(String str) => List<EmployeeModel>.from(json.decode(str).map((x) => EmployeeModel.fromJson(x)));

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(List<EmployeeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//'List<dynamic>' is not a subtype of type 'Map<String, dynamic>'
class EmployeeModel {
  EmployeeModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.department,
    this.birthday,
    this.country,
    this.id,
  });

  String? createdAt;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  List<String>? department;
  String? birthday;
  String? country;
  String? id;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    createdAt: json["createdAt"],
    name: json["name"],
    avatar: json["avatar"],
    email: json["email"],
    phone: json["phone"],
    department: List<String>.from(json["department"].map((x) => x)),
    birthday: json["birthday"],
    country: json["country"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "name": name,
    "avatar": avatar,
    "email": email,
    "phone": phone,
    "department": List<dynamic>.from(department!.map((x) => x)),
    "birthday": birthday,
    "country": country,
    "id": id,
  };
}
