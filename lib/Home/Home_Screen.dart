import 'package:budget_tracking_app/Home/Controller/Home_Controller.dart';
import 'package:budget_tracking_app/Home/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'balance_card.dart';
HomeController controller=Get.put(HomeController());

class BudgetHomePage extends StatelessWidget {
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(),
            SizedBox(height: 20),
            Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text(transaction['date']),
                    trailing: Text("\$${transaction['amount']}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   onTap: (index) {
      //
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.pie_chart_outline),
      //       label: "Stats",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings_outlined),
      //       label: "Settings",
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.insertDb(1500, "food", "10/10/24", 0);
      },child: Icon(Icons.add),),
    );
  }
}
