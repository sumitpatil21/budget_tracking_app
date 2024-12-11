
import 'package:budget_tracking_app/Home/db_Helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    // await DbHelper.dbHelper.database;
    super.onInit();
  }
  //db insert
  Future<void> insertDb(double amount,String category,date,int isincome)
  async {
    await DbHelper.dbHelper.insertRecord(amount, category, date, isincome);
  }
}