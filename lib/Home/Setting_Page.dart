import 'package:budget_tracking_app/Home/HistoryPage.dart';
import 'package:budget_tracking_app/Home/Home_Screen.dart';
import 'package:budget_tracking_app/Home/Statistics_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'NewTransactionPage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get Premium",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "unlock all the features",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.swap_horizontal_circle_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Settings Options
              _buildSettingsOption(
                context,
                icon: Icons.attach_money_rounded,
                title: "Currency",
                trailing: Text(
                  "USD",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              _buildSettingsOption(
                context,
                icon: Icons.share_outlined,
                title: "Share",
              ),
              _buildSettingsOption(
                context,
                icon: Icons.lock_outline,
                title: "Privacy Policy",
              ),
              _buildSettingsOption(
                context,
                icon: Icons.info_outline,
                title: "Terms of Use",
              ),
              _buildSettingsOption(
                context,
                icon: Icons.support_agent_outlined,
                title: "Support",
              ),
              _buildSettingsOption(
                context,
                icon: Icons.delete_outline,
                title: "Delete data",
              ),
              SizedBox(height: 240,),
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
                        InkWell(onTap: () => Get.to(StatisticsPage()),child: _navItem(icon: Icons.pie_chart, label: "Statistics")),
                        _navItem(icon: Icons.settings, label: "Settings", isActive: true),
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

  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon, required String title, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.grey.shade700),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey.shade700),
        onTap: () {
          // Handle option tap
        },
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
