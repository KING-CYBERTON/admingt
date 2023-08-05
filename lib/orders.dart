import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'orderproducts.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No orders available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot orderDoc = snapshot.data!.docs[index];
              Map<String, dynamic> orderData =
                  orderDoc.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(
                        contactName: orderData['contactname'],
                        orderList: orderData['orderlist'],
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('Contact Name: ${orderData['contactname']}'),
                  subtitle: Text('Total: ${orderData['Billedtotal']}'),
                  //atrailing: Text(orderData['orderlist'])
                  // Display more details from the order as needed
                  // For example, orderData['contactphone'], orderData['orderlist'], etc.
                ),
              );
            },
          );
        },
      ),
    );
  }
}
