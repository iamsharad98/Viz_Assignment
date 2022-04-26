import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viz_sharad_assignment/models/checkins_model.dart';
import 'package:viz_sharad_assignment/models/employee_model.dart';
import 'package:viz_sharad_assignment/utils/api_manager.dart';

class EmployeeProfileScreen extends StatefulWidget {

  final int? employeeId;
  const EmployeeProfileScreen.employeeData(this.employeeId, {Key? key}) : super(key: key);

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  EmployeeModel? _employeeDbData;
  List<CheckinsModel>? _employeeCheckinsData;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,() async {
      await getEmployeeData(widget.employeeId!);
      await getCheckinData(widget.employeeId!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: (_employeeDbData == null)? Container() : Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "http://placeimg.com/640/480"
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      alignment: const Alignment(0.0,2.5),
                      child: (_employeeDbData!.avatar == null || _employeeDbData!.avatar == "null")?
                      Image.asset(
                        'assets/images/no_image.png',
                        fit: BoxFit.scaleDown,
                        width: 50,
                        height: 50,
                      ) :
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            _employeeDbData!.avatar ?? ""
                        ),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  _employeeDbData!.name ?? "loading"
                  ,style: const TextStyle(
                    fontSize: 25.0,
                    color:Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Country: ${_employeeDbData!.country}"
                  ,style: const TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: ${_employeeDbData!.email}\nPhone: ${_employeeDbData!.phone}"
                  ,style: const TextStyle(
                    fontSize: 12.0,
                    color:Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Birthday: ${_employeeDbData!.birthday}\nCreated At: ${_employeeDbData!.createdAt}"
                  ,style: const TextStyle(
                    fontSize: 12.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Card(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                    elevation: 2.0,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                        child: Text("Department",style: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),))
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(_employeeDbData!.department != null)
                          Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i=0; i<_employeeDbData!.department!.length; i++)
                                Text("Dpt. ${_employeeDbData!.department![i]}",
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600
                                  ),),
                                const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children:  [
                    const Text("User Checkins:"),
                    (_employeeCheckinsData == null ) ? const Center(child: Text("No Checkins Available"),) :
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics (),
                                padding: EdgeInsets.zero,
                                itemCount: _employeeCheckinsData!.length,
                                separatorBuilder: (context, index) =>Divider(height: 1, color: Colors.grey[300]),
                                itemBuilder: (context, index) {
                                  return Card(
                                      elevation: 0,
                                      color: Colors.white10,
                                      child: ListTile(
                                        title: Text(
                                            _employeeCheckinsData![index].location ?? "loading",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            )
                                        ),
                                        subtitle: Text(
                                          // "1910 S. Highland Ave",
                                          "Date: ${_employeeCheckinsData![index].checkin}\n"
                                              "Purpose: ${_employeeCheckinsData![index].purpose}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "helvetica"
                                          ),
                                        ),
                                        leading: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                            child: Text((index+1).toString())
                                          ),
                                        ),
                                        onTap: () {
                                        },
                                      )
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  getEmployeeData(int employeeId) async {
    final EmployeeModel employeeData = await ApiManager().getSpecificEmployeeApi(employeeId);
    _employeeDbData = employeeData;
    if(_employeeDbData != null){
      print("_employeeDbData!.name ${employeeData.name}");
    }
    setState(() {

    });
  }

  getCheckinData(int employeeId) async {
    final List<CheckinsModel> checkinsData = await ApiManager().getEmployeeCheckinsApi(employeeId);
    _employeeCheckinsData = checkinsData;
    setState(() {
    });
  }
}
