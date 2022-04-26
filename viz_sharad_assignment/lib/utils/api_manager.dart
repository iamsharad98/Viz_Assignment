import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viz_sharad_assignment/models/checkins_model.dart';
import 'package:viz_sharad_assignment/models/employee_model.dart';
import 'package:viz_sharad_assignment/utils/string_utils.dart';

class ApiManager{

  Future<List<EmployeeModel>> getEmployeesApi(int pageNumber, String order , [int limit=10] ) async {
    String url = StringUtils.employeeUrl + "?page=$pageNumber&limit=$limit&sortBy=createdAt&order=$order";
    print("getEmployeesApi $url");
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
          uri,
      );
      // var data = json.decode(response.body);
      if (response.statusCode == 200 ) {

        final List<EmployeeModel> employeesData = employeeListModelFromJson(response.body);
        return employeesData;
      } else {
        return <EmployeeModel>[];
      }
    } catch (e) {
      print("getEmployeesApi error $e");
      return <EmployeeModel>[];
    }
  }

  Future<EmployeeModel> getSpecificEmployeeApi(int employeeId) async {
    String url = "${StringUtils.employeeUrl}/$employeeId";
    print("getEmployeeSearchApi $url");
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
        uri,
      );
      var data = json.decode(response.body);
      print("response $data response.statusCode ${response.statusCode}");
      if (response.statusCode == 200) {

        final EmployeeModel employeesData = employeeListModelFromJson(response.body)[0];
        print("api employeesData ${employeesData.name}");
        return employeesData;
      } else {
        return EmployeeModel();
      }
    } catch (e) {
      print("getSpecificEmployeeApi error $e");
      return EmployeeModel();
    }
  }

  Future<List<EmployeeModel>> getEmployeesSearchApi(String value, String sortByValue) async {

    String url = "";
    if(sortByValue == "Search: name"){
      url = StringUtils.employeeUrl + "?name=$value";
    }else{
      url = StringUtils.employeeUrl + "?country=$value";
    }
    print("getEmployeesSearchApi $url");
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
        uri,
      );
      // var data = json.decode(response.body);
      if (response.statusCode == 200 ) {

        final List<EmployeeModel> employeesData = employeeListModelFromJson(response.body);
        return employeesData;
      } else {
        return <EmployeeModel>[];
      }
    } catch (e) {

      print("getEmployeesSearchApi error $e");
      return <EmployeeModel>[];
    }
  }

  Future<List<CheckinsModel>> getEmployeeCheckinsApi(int employeeId) async {
    String url = "${StringUtils.employeeUrl}/$employeeId/checkin/";
    print("getEmployeeCheckinsApi $url");
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
        uri,
      );
      // var data = json.decode(response.body);
      if (response.statusCode == 200 ) {

        final List<CheckinsModel> checkinsModelData = checkinsListModelFromJson(response.body);
        return checkinsModelData;
      } else {
        return <CheckinsModel>[];
      }
    } catch (e) {
      print("getEmployeeCheckinsApi error $e");
      return <CheckinsModel>[];
    }
  }

  Future<CheckinsModel> getParticularCheckinsApi(int employeeId, int checkinsId) async {
    String url = "${StringUtils.employeeUrl}/$employeeId/checkin/$checkinsId";
    print("getParticularCheckinsApi $url");
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
        uri,
      );
      // var data = json.decode(response.body);
      if (response.statusCode == 200 ) {

        final CheckinsModel checkinsModel = checkinsModelFromJson(response.body);
        return checkinsModel;
      } else {
        return CheckinsModel();
      }
    } catch (e) {
      print("getParticularCheckinsApi error $e");
      return CheckinsModel();
    }
  }

}