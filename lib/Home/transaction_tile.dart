import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final IconData icon;
  final Color color;

  TransactionTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: transactions.isEmpty
                ? Center(child: Text("No Transactions Found"))
                : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return Dismissible(
                  key: ValueKey(transaction['id']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) {

                      transactions.removeAt(index);

                    // Show confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Transaction removed"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  },
                  child: TransactionTile(
                    title: transaction['title'],
                    date: transaction['date'].split('T').first,
                    amount: transaction['type'] == 'income'
                        ? "+\$${transaction['amount']}"
                        : "-\$${transaction['amount']}",
                    icon: transaction['type'] == 'income'
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: transaction['type'] == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                );
              },
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: amount.contains('-') ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
List<Map<String, dynamic>> transactions = [
  {
    'id': 1,
    'title': 'Groceries',
    'amount': 120.50,
    'date': '2024-12-10T14:32:00',
    'type': 'expense'
  },
  {
    'id': 2,
    'title': 'Salary',
    'amount': 2500.00,
    'date': '2024-12-05T09:00:00',
    'type': 'income'
  },
  {
    'id': 3,
    'title': 'Internet Bill',
    'amount': 60.00,
    'date': '2024-12-03T16:45:00',
    'type': 'expense'
  },
  {
    'id': 4,
    'title': 'Freelance Project',
    'amount': 800.00,
    'date': '2024-12-01T10:00:00',
    'type': 'income'
  },
];
