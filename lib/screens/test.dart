// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.purple,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: HomePage());
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final DBref = FirebaseDatabase.instance.reference();
//   int ledStatus = 0;
//   bool isLoading = false;

//   getLEDStatus() async {
//     await DBref.child('LED_STATUS').once().then((DataSnapshot snapshot) {
//       ledStatus = snapshot.value;
//       print(ledStatus);
//     });

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     isLoading = true;
//     getLEDStatus();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'IOT App',
//           // style:
//           // GoogleFonts.montserrat(fontSize: 25, fontStyle: FontStyle.italic),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 isLoading
//                     ? CircularProgressIndicator()
//                     : RaisedButton(
//                         child: Text(
//                           ledStatus == 0 ? 'On_0' : 'Off_0',
//                           // style: GoogleFonts.nunito(
//                           // fontSize: 20, fontWeight: FontWeight.w300),
//                         ),
//                         onPressed: () {
//                           buttonPressed();
//                         },
//                       ),
//               ],
//             ),
//             Container(
//               child: RaisedButton(
//                 child: Text(
//                   ledStatus == 0 ? '' : '',
//                   // style: GoogleFonts.nunito(
//                   // fontSize: 20, fontWeight: FontWeight.w300),
//                 ),
//                 onPressed: () {
//                   buttonPressed1();
//                 },
//               ),
//             ),
//           ],
//         ),

//         //  RaisedButton(
//         //   child: Text(
//         //     ledStatus == 0 ? 'On_0' : 'Off_0',
//         //     // style: GoogleFonts.nunito(
//         //         // fontSize: 20, fontWeight: FontWeight.w300),
//         //   ),
//         //   onPressed: () {
//         //     buttonPressed1();
//         //   },
//         // ),
//       ),
//     );
//   }

//   void buttonPressed() {
//     ledStatus == 0
//         ? DBref.child('IOT2/LED0').set(1)
//         : DBref.child('IOT2/LED0').set(0);
//     if (ledStatus == 0) {
//       setState(() {
//         ledStatus = 1;
//       });
//     } else {
//       setState(() {
//         ledStatus = 0;
//       });
//     }
//   }

//   void buttonPressed1() {
//     ledStatus == 0
//         ? DBref.child('IOT2/LED1').set(1)
//         : DBref.child('IOT2/LED1').set(0);
//     if (ledStatus == 0) {
//       setState(() {
//         ledStatus = 1;
//       });
//     } else {
//       setState(() {
//         ledStatus = 0;
//       });
//     }
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class IotScreen extends StatefulWidget {
  @override
  _IotScreenState createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen>
    with SingleTickerProviderStateMixin {
  @override
  final dbRef = FirebaseDatabase.instance.reference();
  bool value = false;
  Color color = Colors.grey;

  onUpdate() {
    setState(() {
      value = !value;
    });
    
}

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("DRAWER HEADER.."),
              decoration: new BoxDecoration(color: Colors.orange),
            ),
            new ListTile(
              title: new Text("Room 1"),
              onTap: () {},
            ),
            new ListTile(
              title: new Text("Room 2"),
              onTap: () {},
            ),
          ],
        )),
        body: SafeArea(
          child: StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState.openDrawer();
                              },

                              child: Icon(
                                Icons.clear_all,
                                color: !value ? Colors.white : Colors.yellow,
                              ),
                              // ),
                            ),
                            Text("MY ROOM",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),

                            Icon(
                              Icons.settings,
                              color: !value ? Colors.white : Colors.yellow,
                            ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("เซนเซอร์ตรวจจับควัน",
                                    style: TextStyle(
                                        color: !value
                                            ? Colors.white
                                            : Colors.yellow,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data.snapshot.value["Value"]
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else {}
                return Container();
              },
              stream: dbRef.child("Sensor").onValue),
        ),
      ),
    );
  }

 
  

  Future<void> readData() async {
    dbRef.child("Sensor").once().then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }
}