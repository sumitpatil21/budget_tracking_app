
import 'package:budget_tracking_app/Home/Modal/Home_Modal.dart';
import 'package:budget_tracking_app/Home/db_Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    fetchValue();
    // await DbHelper.dbHelper.database;
    super.onInit();
  }
  RxDouble? income=0.0.obs;
  RxDouble? expenses=0.0.obs;
  RxDouble? balance=0.0.obs;
  RxBool? isIncome=false.obs;
  RxInt selectedCategoryIndex = (-1).obs;
  List categories = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Car", "icon": Icons.directions_car},
    {"name": "Travel", "icon": Icons.card_travel},
    {"name": "Bar", "icon": Icons.local_bar},
    {"name": "Food", "icon": Icons.restaurant},
    {"name": "Clothes", "icon": Icons.shopping_bag},
    {"name": "Pets", "icon": Icons.pets},
    {"name": "Health", "icon": Icons.local_hospital},
    {"name": "Phone", "icon": Icons.phone_android},
    {"name": "Internet", "icon": Icons.wifi},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Cafe", "icon": Icons.local_cafe},
    {"name": "Toiletry", "icon": Icons.soap},
    {"name": "Bills", "icon": Icons.receipt_long},
  ];
  void switchIncome(bool value)
  {
    isIncome!.value=value;
  }
  
  TextEditingController txtAmount=TextEditingController();
  TextEditingController txtCategory=TextEditingController();
  TextEditingController txtDate=TextEditingController();
  RxList<HomeModal> budgetList= <HomeModal>[].obs;
  //db insert
  Future<void> insertDb(double amount,String category,date,int isincome)
  async {
    await DbHelper.dbHelper.insertRecord(amount, category, date,isincome);
    await fetchValue();
  }
  Future<void> fetchValue()
  async {
    final record = await DbHelper.dbHelper.fetchData();
    budgetList.value =record.map((e)=>HomeModal.fromjson(e),).toList();
    calculateBalance();
  }

  Future<void>deleteDb(int index)
  async {
   await DbHelper.dbHelper.deleteData(index);
   await fetchValue();

  }
 Future<void> updateDb(int id, double amount, String category, String date, int isincome)
 async {
   await DbHelper.dbHelper.dbUpdateRecord(id: id, amt: amount, category: category, isIncome: isincome, date: date);
   await fetchValue();
 }

 void calculateBalance()
 {
   double totalIncome=0.0;
   double totalExpenses=0.0;
   for(var record in budgetList)
     {

       if(record.isincome==1)
         {
           totalIncome+=record.amount!;
         }
       else
         {
           totalExpenses+=record.amount!;
         }
     }
   income!.value=totalIncome;
   expenses!.value=totalExpenses;
   balance!.value=income!.value-expenses!.value;
 }

}