import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
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
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://placeimg.com/640/480"
                      ),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Sharad Pareek"
                ,style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Rajasthan, India"
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Email: shrdprk34@gmail.com,\nPhone: +91 8209278477"
                ,style: TextStyle(
                  fontSize: 12.0,
                  color:Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Birthday: 1 Jan 1998\nCreated At: 25 April 2022"
                ,style: TextStyle(
                  fontSize: 12.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i=0; i<4; i++)
                              Text("Dpt. $i",
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     RaisedButton(
              //       onPressed: (){
              //       },
              //       shape:  RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(80.0),
              //       ),
              //       child: Ink(
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.centerLeft,
              //               end: Alignment.centerRight,
              //               colors: [Colors.pink,Colors.redAccent]
              //           ),
              //           borderRadius: BorderRadius.circular(30.0),
              //         ),
              //         child: Container(
              //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Contact me",
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.0,
              //                 letterSpacing: 2.0,
              //                 fontWeight: FontWeight.w300
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     RaisedButton(
              //       onPressed: (){
              //       },
              //       shape:  RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(80.0),
              //       ),
              //       child: Ink(
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.centerLeft,
              //               end: Alignment.centerRight,
              //               colors: [Colors.pink,Colors.redAccent]
              //           ),
              //           borderRadius: BorderRadius.circular(80.0),
              //         ),
              //         child: Container(
              //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Portfolio",
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.0,
              //                 letterSpacing: 2.0,
              //                 fontWeight: FontWeight.w300
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        )
    );
  }

}

