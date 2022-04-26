// To parse this JSON data, do
//
//     final checkinsModel = checkinsListModelFromJson(jsonString);
//     final checkinsModel = checkinsModelFromJson(jsonString);

import 'dart:convert';

List<CheckinsModel> checkinsListModelFromJson(String str) => List<CheckinsModel>.from(json.decode(str).map((x) => CheckinsModel.fromJson(x)));
String checkinsListModelToJson(List<CheckinsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CheckinsModel checkinsModelFromJson(String str) => CheckinsModel.fromJson(json.decode(str));
String checkinsModelToJson(CheckinsModel data) => json.encode(data.toJson());

class CheckinsModel {
  CheckinsModel({
    this.checkin,
    this.location,
    this.purpose,
    this.id,
    this.employeeId,
  });

  String? checkin;
  String? location;
  String? purpose;
  String? id;
  String? employeeId;

  factory CheckinsModel.fromJson(Map<String, dynamic> json) => CheckinsModel(
    checkin: json["checkin"],
    location: json["location"],
    purpose: json["purpose"],
    id: json["id"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toJson() => {
    "checkin": checkin,
    "location": location,
    "purpose": purpose,
    "id": id,
    "employeeId": employeeId,
  };
}
