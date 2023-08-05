import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String contactName;
  final List<dynamic> orderList;

  const OrderDetailScreen({
    super.key,
    required this.contactName,
    required this.orderList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactName),
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> productData = orderList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(productData['PImage']),
              title: Text(
                  "${productData['PName']}\n quantity: ${productData['quantity']} "),
              // Add more details as needed, e.g., productData['price'], productData['quantity'], etc.
            ),
          );
        },
      ),
    );
  }
}
