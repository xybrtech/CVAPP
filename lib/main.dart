import 'package:COVAPP/providers/users.dart';
import 'package:COVAPP/screens/barcode.dart';

import 'package:COVAPP/screens/landingNew.dart';
import 'package:COVAPP/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/authold.dart';
import 'providers/vaccineitems.dart';
import 'screens/history.dart';

//import 'screens/history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //List<VaccineItem> _vaccineItems;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: VaccineItems(),
        ),
      ],
      child: MaterialApp(
        title: 'COVAPP',
        initialRoute: "/splash",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/splash": (BuildContext context) => new Splash(),
          "/landing": (BuildContext context) => new Landing(),
          "/barcode": (BuildContext context) => new Barcode(),
          "/history": (BuildContext context) => new History(),
        },
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MyHomePage(title: 'Splash'),
      ),
    );
  }
}
