import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/blocs/auth_bloc.dart';
import 'package:smarthome/screens/authen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbRef = FirebaseDatabase.instance.reference();
  bool value = false;
  int ledStatus0 = 0;
  int ledStatus1 = 0;
  int ledStatus2 = 0;
  int ledStatus3 = 0;
  Color color = Colors.grey;

  onUpdate0() {
    setState(() {
      value = !value;
    });
  }

  onUpdate1() {
    setState(() {
      value = !value;
    });
  }

  onUpdate2() {
    setState(() {
      value = !value;
    });
  }

  onUpdate3() {
    setState(() {
      value = !value;
    });
  }

  getLEDStatus0() async {
    await dbRef.child('LED_STATUS').once().then((DataSnapshot snapshot) {
      ledStatus1 = snapshot.value;
      print(ledStatus1);
    });

    setState(() {
      value = false;
    });
  }

  getLEDStatus1() async {
    await dbRef.child('LED_STATUS').once().then((DataSnapshot snapshot) {
      ledStatus1 = snapshot.value;
      print(ledStatus1);
    });

    setState(() {
      value = false;
    });
  }

  getLEDStatus2() async {
    await dbRef.child('LED_STATUS').once().then((DataSnapshot snapshot) {
      ledStatus2 = snapshot.value;
      print(ledStatus2);
    });

    setState(() {
      value = false;
    });
  }

  getLEDStatus3() async {
    await dbRef.child('LED_STATUS').once().then((DataSnapshot snapshot) {
      ledStatus3 = snapshot.value;
      print(ledStatus3);
    });

    setState(() {
      value = false;
    });
  }

  StreamSubscription<User> loginStateSubscription;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen(
      (fbUser) {
        if (fbUser == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Authen(),
            ),
          );
        }
      },
    );
    super.initState();
    getLEDStatus1();
    getLEDStatus2();
    getLEDStatus3();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20.0),
                      showButton0(context),
                      SizedBox(height: 20.0),
                      showUser(authBloc),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                showTemperature(),
                                showHumidity(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                showSmokeSensor(),
                                showWaterSensor(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(height: 120),
                                showButton1(context),
                                showButton2(context),
                                showButton3(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100.0),
                      showSignOut(authBloc)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row showButton0(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.12,
            width: 80,
            child: FloatingActionButton.extended(
              icon: ledStatus0 == 0
                  ? Icon(Icons.security)
                  : Icon(Icons.security_outlined),
              backgroundColor: ledStatus0 == 0 ? Colors.yellow : Colors.blue,
              label: ledStatus0 == 0 ? Text("ON") : Text("OFF"),
              elevation: 8.00,
              onPressed: () {
                onUpdate0();
                buttonPressed0();
              },
            ),
          ),
        ),
      ],
    );
  }

  Column showSignOut(AuthBloc authBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInButton(
          Buttons.Google,
          text: 'Sign Out of Google',
          onPressed: () => authBloc.logout(),
        ),
      ],
    );
  }

  Padding showButton3(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: 80,
        child: FloatingActionButton.extended(
          icon: ledStatus3 == 0
              ? Icon(Icons.water_damage)
              : Icon(Icons.water_damage_outlined),
          backgroundColor: ledStatus3 == 0 ? Colors.yellow : Colors.blue,
          label: ledStatus3 == 0 ? Text("ON") : Text("OFF"),
          elevation: 8.00,
          onPressed: () {
            onUpdate3();
            buttonPressed3();
          },
        ),
      ),
    );
  }

  Padding showButton2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: 80,
        child: FloatingActionButton.extended(
          icon: ledStatus2 == 0
              ? Icon(Icons.sensor_door)
              : Icon(Icons.sensor_door_outlined),
          backgroundColor: ledStatus2 == 0 ? Colors.yellow : Colors.blue,
          label: ledStatus2 == 0 ? Text("ON") : Text("OFF"),
          elevation: 8.00,
          onPressed: () {
            onUpdate2();
            buttonPressed2();
          },
        ),
      ),
    );
  }

  Padding showButton1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: 80,
        child: FloatingActionButton.extended(
          icon: ledStatus1 == 0
              ? Icon(Icons.lightbulb)
              : Icon(Icons.lightbulb_outline),
          backgroundColor: ledStatus1 == 0 ? Colors.yellow : Colors.blue,
          label: ledStatus1 == 0 ? Text("ON") : Text("OFF"),
          elevation: 8.00,
          onPressed: () {
            onUpdate1();
            buttonPressed1();
          },
        ),
      ),
    );
  }

  StreamBuilder<Event> showWaterSensor() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40.0,
                            child: Image.asset('assets/4.png'),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "เซนเซอร์วัดน้ำ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.snapshot.value["WarterSensor"]
                                .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
        stream: dbRef.child("Warter").onValue);
  }

  StreamBuilder<Event> showSmokeSensor() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45.0,
                            child: Image.asset('assets/1.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "เซนเซอร์ตรวจจับควัน",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.snapshot.value["Value"].toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
        stream: dbRef.child("Sensor").onValue);
  }

  StreamBuilder<Event> showHumidity() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40.0,
                            child: Image.asset('assets/3.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ความชื้น",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.snapshot.value["Humidity"]
                                    .toString() +
                                " %",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
        stream: dbRef.child("DHT").onValue);
  }

  StreamBuilder<Event> showTemperature() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40.0,
                            child: Image.asset('assets/2.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "อุณหภูมิ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.snapshot.value["Temperature"]
                                    .toString() +
                                " °C",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
        stream: dbRef.child("DHT").onValue);
  }

  StreamBuilder<User> showUser(AuthBloc authBloc) {
    return StreamBuilder<User>(
      stream: authBloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          children: [
            CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data.photoURL),
                radius: 30.0),
            SizedBox(height: 20.0),
            Text('สวัสดี!! คุณ', style: TextStyle(fontSize: 18.0)),
            Text(snapshot.data.displayName, style: TextStyle(fontSize: 25.0)),
            SizedBox(height: 5.0),
            Text('ยินดีต้อนรับกลับบ้าน', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 20.0),
          ],
        );
      },
    );
  }

  void buttonPressed0() {
    ledStatus0 == 0
        ? dbRef.child('IOT2/LED0').set("1")
        : dbRef.child('IOT2/LED0').set("0");
    if (ledStatus0 == 0) {
      setState(() {
        ledStatus0 = 1;
      });
    } else {
      setState(() {
        ledStatus0 = 0;
      });
    }
  }

  void buttonPressed1() {
    ledStatus1 == 0
        ? dbRef.child('IOT2/LED1').set("1")
        : dbRef.child('IOT2/LED1').set("0");
    if (ledStatus1 == 0) {
      setState(() {
        ledStatus1 = 1;
      });
    } else {
      setState(() {
        ledStatus1 = 0;
      });
    }
  }

  void buttonPressed2() {
    ledStatus2 == 0
        ? dbRef.child('IOT2/LED2').set("1")
        : dbRef.child('IOT2/LED2').set("0");
    if (ledStatus2 == 0) {
      setState(() {
        ledStatus2 = 1;
      });
    } else {
      setState(() {
        ledStatus2 = 0;
      });
    }
  }

  void buttonPressed3() {
    ledStatus3 == 0
        ? dbRef.child('IOT2/LED3').set("1")
        : dbRef.child('IOT2/LED3').set("0");
    if (ledStatus3 == 0) {
      setState(() {
        ledStatus3 = 1;
      });
    } else {
      setState(() {
        ledStatus3 = 0;
      });
    }
  }
}
