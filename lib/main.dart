import 'package:budget_tracking_app/Home/SplaceScreen.dart';
import 'package:budget_tracking_app/Home/db_Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home/Home_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.database;
  runApp(BudgetTrackingApp());
}

class BudgetTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: BudgetHomePage(),
    );
  }
}
