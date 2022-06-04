import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:record_waste_money/login_page.dart';
import 'package:record_waste_money/money_list/money_list_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyMoneyApp());
}

class MyMoneyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Record Waste Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}


