import 'package:budget_tracking_app/Home/Controller/Home_Controller.dart';
import 'package:budget_tracking_app/Home/HistoryPage.dart';
import 'package:budget_tracking_app/Home/NewTransactionPage.dart';
import 'package:budget_tracking_app/Home/Setting_Page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Statistics_Page.dart';
import 'balance_card.dart';

HomeController controller = Get.put(HomeController());

class BudgetHomePage extends StatelessWidget {
  final RxString searchQuery = "".obs; // Reactive search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Budget Tracker",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.person),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Balance Section
            Container(
              height: 90,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total balance",
                      style: TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                    Obx(
                      () => Text(
                        controller.balance!.value.toString(),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      BalanceCard(
                        gradientColors: [Colors.blueAccent, Colors.blue],
                        balance: controller.income.toString(),
                        cardTitle: "Income",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      BalanceCard(
                        gradientColors: [Colors.redAccent, Colors.red],
                        balance: controller.expenses.toString(),
                        cardTitle: "Expenses",
                      ),
                    ],
                  ),
                )),

            // Search Bar
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  searchQuery.value = value; // Update the search query
                },
                decoration: InputDecoration(
                  hintText: "Search transactions...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            // Recent Transactions Label
            Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),

            // Filtered Transactions List
            Expanded(
              child: Obx(
                () {
                  // Filter transactions based on the search query
                  final filteredTransactions =
                      controller.budgetList.where((transaction) {
                    final query = searchQuery.value.toLowerCase();
                    return transaction.category!
                            .toLowerCase()
                            .contains(query) ||
                        transaction.amount!.toString().contains(query);
                  }).toList();

                  // Show filtered transactions
                  return ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return Dismissible(
                        key: Key(transaction.id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          final id = transaction.id!;
                          controller.budgetList.removeAt(index);
                          await controller.deleteDb(id);
                          Get.snackbar(
                              "Deleted", "Transaction removed successfully!");
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Icon container
                              Container(
                                padding: EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // Add category icon if needed
                              ),
                              SizedBox(width: 15),

                              // Transaction details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      transaction.category!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),

                              // Amount & Date
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    transaction.isincome == 1
                                        ? "+ ₹${transaction.amount!.toStringAsFixed(2)}"
                                        : "- ₹${transaction.amount!.abs().toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: transaction.isincome == 1
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    transaction.date!,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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


                           _navItem(
                              icon: Icons.home, label: "Home", isActive: true),
                      InkWell(
                          onTap: () {
                            Get.to(HistoryPage());
                          },
                          child:
                              _navItem(icon: Icons.history, label: "History")),
                      SizedBox(width: 70), // Space for floating button
                      InkWell(
                          onTap: () => Get.to(StatisticsPage()),
                          child: _navItem(
                              icon: Icons.pie_chart, label: "Statistics")),
                      InkWell(
                          onTap: () => Get.to(SettingsPage()),
                          child: _navItem(
                            icon: Icons.settings,
                            label: "Settings",
                          )),
                    ],
                  ),

                  // Floating Action Button (centered above)
                  Positioned(
                    top: -28,
                    left: MediaQuery.of(context).size.width / 2 - 45,
                    child: InkWell(
                      onTap: () => Get.to(()=> NewTransactionPage()),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child:
                           Icon(Icons.add, color: Colors.white, size: 30),
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
