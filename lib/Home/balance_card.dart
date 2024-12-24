import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final List<Color> gradientColors;
  final String cardTitle;
  final String balance;

  BalanceCard({
    required this.gradientColors,
    this.cardTitle = "Cash",
    this.balance = "\$ 124 890.01",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors, // Use passed gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Card Title with Edit Icon
          Positioned(
            top: 15,
            left: 20,
            child: Row(
              children: [
                Text(
                  cardTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),

          // Balance Amount
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              balance,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          // Circular Overlay Decorations
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            right: -80,
            top: -80,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
