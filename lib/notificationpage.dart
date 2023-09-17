import 'package:flutter/material.dart';



class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    " Food fly Your order has been confirmed.",
    "Food fly Your order is out for delivery.",
    " Food fly Special offer: Get 10% off on your next order!",
    "Food fly Special offer: Get 30% off on your next order! ",
        "Food fly Special offer: Get 20% off on your next order! "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notifications[index]),
            onTap: () {
              // You can add functionality to handle the notification tap here
              // For example, navigate to a specific screen when a notification is tapped.
              print("Notification tapped: ${notifications[index]}");
            },
          );
        },
      ),
    );
  }
}
