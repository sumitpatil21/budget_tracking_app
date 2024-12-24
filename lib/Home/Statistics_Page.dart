import 'package:budget_tracking_app/Home/Home_Screen.dart';
import 'package:budget_tracking_app/Home/NewTransactionPage.dart';
import 'package:budget_tracking_app/Home/Setting_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';


import 'Controller/Home_Controller.dart';
import 'HistoryPage.dart'; // Add this package for visual pie charts.

class StatisticsPage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Card
              Obx(() => _buildSummaryCard(
                homeController.income!.value,
                homeController.expenses!.value,
                homeController.balance!.value,
              )),
              SizedBox(height: 20),
          
              // Pie Chart for Expenses
              Obx(() {
                final expenseData = _getCategoryWiseData(isIncome: false);
                return _buildPieChart(
                  "Expenses Breakdown",
                  expenseData,
                );
              }),
          
              SizedBox(height: 20),
          
              // Pie Chart for Income
              Obx(() {
                final incomeData = _getCategoryWiseData(isIncome: true);
                return _buildPieChart(
                  "Income Breakdown",
                  incomeData,
                );
              }),
              Container(
                height: 100, // Fixed height
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, -3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Bottom navigation items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(onTap: () => Get.to(BudgetHomePage()),child: _navItem(icon: Icons.home, label: "Home")),
                        InkWell(onTap: () {
                          Get.to(HistoryPage());
                        },child: _navItem(icon: Icons.history, label: "History")),
                        SizedBox(width: 70), // Space for floating button
                        InkWell(onTap: () => Get.to(StatisticsPage()),child: _navItem(icon: Icons.pie_chart, label: "Statistics", isActive: true)),
                        InkWell(onTap:() => Get.to(SettingsPage()), child: _navItem(icon: Icons.settings, label: "Settings",)),
                      ],
                    ),

                    // Floating Action Button (centered above)
                    Positioned(
                      top: -28,
                      left: MediaQuery.of(context).size.width / 2 - 45,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          onPressed: () {
                            Get.to(NewTransactionPage());
                          },
                          icon: Icon(Icons.add, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // Widget for Summary Card
  Widget _buildSummaryCard(double income, double expenses, double balance) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Balance: \$${balance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Income: \$${income.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  "Expenses: \$${expenses.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  // Widget for Pie Chart
  Widget _buildPieChart(String title, Map<String, double> dataMap) {
    if (dataMap.isEmpty) {
      return Center(
        child: Text(
          "No data available for $title.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        PieChart(
          // colorList: [(homeController.isIncome) != null?Colors.green:Colors.red],
          dataMap: dataMap,

          chartType: ChartType.ring,
          ringStrokeWidth: 20,
          animationDuration: Duration(seconds: 1),
          chartLegendSpacing: 80,
          legendOptions: LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.left,
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
        ),
      ],
    );
  }

  // Helper Method to Get Category-wise Data
  Map<String, double> _getCategoryWiseData({required bool isIncome}) {
    Map<String, double> categoryData = {};

    for (var record in homeController.budgetList) {
      if (record.isincome == (isIncome ? 1 : 0)) {
        final category = record.category ?? "Other";
        categoryData[category] = (categoryData[category] ?? 1) + record.amount!;
        print(categoryData);
      }
    }

    return categoryData;
  }
}



Widget _navItem({
  required IconData icon,
  required String label,
  bool isActive = false,
  final pass,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
          onTap: () {
            pass;
          },
          child: Icon(icon,
              color: isActive ? Colors.blue : Colors.grey, size: 30)),
      SizedBox(height: 5),
      Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
    ],
  );
}
