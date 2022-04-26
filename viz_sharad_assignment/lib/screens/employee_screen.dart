import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viz_sharad_assignment/models/employee_model.dart';
import 'package:viz_sharad_assignment/screens/employee_profile_screen.dart';
import 'package:viz_sharad_assignment/screens/new_search_screen.dart';
import 'package:viz_sharad_assignment/utils/api_manager.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  final _searchFieldController =  TextEditingController();
  List<EmployeeModel>? _employeeDbData;
  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  int _currentPageNumber = 1;
  String? currSortByValue = "Created At: Asc";
  List<String> items = [
    'Created At: Asc',
    'Created At: Desc',
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      //your async 'await' codes goes here
      await callApi(1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [Colors.grey[350] ?? Colors.grey, Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/sample_logo.png',
                      width: 25,
                      height: 55,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 10),
                    const Text("Vizmo Assignment",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _searchFieldController,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Search Employees...',
                    hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 14, top: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.none,
                  showCursor: false,
                  onChanged: (value) {

                  },
                  onTap: () async {
                    _searchFieldController.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Employees"),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Sort By',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: items
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: currSortByValue,
                        onChanged: (value) {
                          setState(() {
                            currSortByValue = value as String;
                          });
                          if(currSortByValue == "Created At: Asc"){
                            callApi(_currentPageNumber, "asc");
                          }else{
                            callApi(_currentPageNumber, "desc");
                          }
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if(_employeeDbData != null)
                  Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: true,
                          onRefresh: () async {
                            _currentPageNumber = 1;
                            await callApi(1);
                            if(_employeeDbData != null || _employeeDbData!.isNotEmpty){
                              _refreshController.refreshCompleted();
                            }else{
                              _refreshController.refreshFailed();
                            }
                            setState(() {});
                          },
                          onLoading: () async {
                            _currentPageNumber = _currentPageNumber + 1;
                            await callApi(_currentPageNumber);
                            _refreshController.loadComplete();
                          },
                          child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics (),
                              padding: EdgeInsets.zero,
                              itemCount: _employeeDbData!.length,
                              separatorBuilder: (context, index) =>Divider(height: 1, color: Colors.grey[300]),
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 0,
                                    color: Colors.white10,
                                    child: ListTile(
                                      title: Text(
                                          _employeeDbData![index].name ?? "loading",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          )
                                      ),
                                      subtitle: Text(
                                        // "1910 S. Highland Ave",
                                        _employeeDbData![index].email ?? "loading",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: "helvetica"
                                        ),
                                      ),
                                      leading: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                          child: (_employeeDbData![index].avatar != null && _employeeDbData![index].avatar!.isNotEmpty) ?
                                            Image.network(_employeeDbData![index].avatar ?? "") : const Icon(Icons.downloading),
                                        ),
                                      ),
                                      // trailing: const Icon(
                                      //   Icons.cancel,
                                      //   size: 20,
                                      // ),
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              EmployeeProfileScreen.employeeData(int.parse(_employeeDbData![index].id ?? "0")),
                                        ));
                                      },
                                    )
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  callApi(int pageNumber, [String order = "asc"]) async {
    if(currSortByValue == "Created At: Desc"){
      order = "desc";
    }
    final List<EmployeeModel> employeeData = await ApiManager().getEmployeesApi(pageNumber, order);

    if(pageNumber == 1){
      _employeeDbData = employeeData;
    }else{
      _employeeDbData!.addAll(employeeData);
    }
    setState(() {});
  }
}
