import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:viz_sharad_assignment/models/employee_model.dart';
import 'package:viz_sharad_assignment/screens/employee_profile_screen.dart';
import 'package:viz_sharad_assignment/utils/api_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchFieldController =  TextEditingController();
  List<EmployeeModel> searchResults = [];
  String currSortByValue = "Search: country";
  List<String> items = [
    'Search: country',
    'Search: name',
  ];

  @override
  void initState() {

    Future.delayed(Duration.zero,() async {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextField(
                      controller: _searchFieldController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      decoration: InputDecoration(
                        prefix: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Icon(Icons.arrow_back, size: 20, color: Colors.black,),
                            ),
                          ),
                        ),
                        suffix: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                          child: InkWell(
                            onTap: (){
                              _searchFieldController.clear();
                            },
                            child: Container(
                              child: Icon(Icons.clear, size: 20, color: Colors.grey,),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Search Employee',
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 14, top: 14),

                      ),
                      onChanged: (value) {
                        setSearchResults(value);
                      },
                      onTap: () {

                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Sort By',
                              style: TextStyle(
                                fontSize: 12,
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
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if(searchResults.length >0)
                  const Text("Results:"),
                if(searchResults.length >  0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                      height: 300.0,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: searchResults.length,
                          separatorBuilder: (context, index) =>Divider(height: 1, color: Colors.grey),
                          itemBuilder: (context, index) {
                            // print("isSearchMatch[index] ${isSearchMatch[index]}");
                            return Card(
                                elevation: 0,
                                color: Colors.grey[350],
                                child: ListTile(
                                  title: Text(
                                      // "Visint Office $index",
                                      searchResults[index].name ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      )
                                  ),
                                  // subtitle: Text(" ${subtitles[index]} \n${parkAvailable[index]} Free Parking"
                                  subtitle: Text(
                                    searchResults[index].country ?? "",
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontFamily: "helvetica"
                                    ),
                                  ),
                                  onTap: () {
                                    if(searchResults[index].id != null){
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EmployeeProfileScreen.employeeData(int.parse(searchResults[index].id ?? "0")),
                                      ));
                                    }else {
                                      _showToast(context, "Server Issue, Please try again later");
                                    }
                                  },
                                )
                            );
                          }),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setSearchResults(var value) async{

    var resList = await ApiManager().getEmployeesSearchApi(value, currSortByValue);
    searchResults = [];
    searchResults = resList;
    setState(() {});

  }

  void _showToast(BuildContext context, String textValue) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(textValue),
        // animation: Animation(),
        action: SnackBarAction(label: 'Ok',
            onPressed: scaffold.hideCurrentSnackBar
        ),
      ),
    );
  }

}
