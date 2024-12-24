import 'package:budget_tracking_app/Home/Home_Screen.dart';
import 'package:budget_tracking_app/Home/Setting_Page.dart';
import 'package:budget_tracking_app/Home/Statistics_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/Home_Controller.dart';
import 'NewTransactionPage.dart';

class HistoryPage extends StatelessWidget {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "History",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            // Timeframe Filters with Incremented Size and Spacing
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterButton("Day", isActive: false),
                  SizedBox(width: 10),
                  _buildFilterButton("Week", isActive: false),
                  SizedBox(width: 10),
                  _buildFilterButton("Month", isActive: true),
                  SizedBox(width: 10),
                  _buildFilterButton("Year", isActive: false),
                  SizedBox(width: 10),
                  _buildFilterButton("All", isActive: false),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.chevron_left, color: Colors.grey, size: 30),
                Text(
                  "October",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey, size: 30),
              ],
            ),
            SizedBox(height: 20),

            // Income & Expenses Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard("Income", "+0.00 \$", Colors.green),
                _buildSummaryCard("Expenses", "-0.00 \$", Colors.red),
              ],
            ),
            SizedBox(height: 30),

            // No Transactions Illustration
             Expanded(
              child: Obx(() => ListView.builder(
                itemCount: homeController.budgetList.length,
                itemBuilder: (context, index) {
                  final transaction = homeController.budgetList[index];
                  return ListTile(
                    leading: Icon(
                      transaction.isincome == 1 ? Icons.add : Icons.remove,
                      color: transaction.isincome == 1 ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction.category!),
                    subtitle: Text(transaction.date!),
                    trailing: Text(
                      "\$${transaction.amount!.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: transaction.isincome == 1 ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              )),
            ),

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
                      InkWell(onTap: () => Get.to(BudgetHomePage()),child: _navItem(icon: Icons.home, label: "Home", )),
                      InkWell(onTap: () {
                        Get.to(HistoryPage());
                      },child: _navItem(icon: Icons.history, label: "History",isActive: true)),
                      SizedBox(width: 70), // Space for floating button
                      InkWell(onTap: () => Get.to(StatisticsPage()),child: _navItem(icon: Icons.pie_chart, label: "Statistics")),
                      InkWell(onTap: () => Get.to(SettingsPage()),child: _navItem(icon: Icons.settings, label: "Settings")),
                    ],
                  ),

                  // Floating Action Button (centered above)
                  Positioned(
                    top: -28,
                    left: MediaQuery.of(context).size.width / 2 - 60,
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

    );
  }

  Widget _buildFilterButton(String label, {bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color:  isActive?Colors.white:Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
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
