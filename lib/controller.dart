import 'package:cloud_firestore/cloud_firestore.dart';

// Define a class to represent the order data

class Orders {
  final String contactname;
  final String contactphone;
  final String total;
  final String? mpesaname;
  final String? mpesnumber;
  final String? mpesacode;
  final List orderlist;

  const Orders( {
    required this.contactname,
    required this.contactphone,
    required this.total,
    required this.mpesaname,
    required this.mpesnumber,
    required this.mpesacode,
    required this.orderlist, 
  });


}

class OrderService {
  // Function to fetch orders from Firestore
  static Future<List<Orders>> fetchOrdersFromFirestore() async {
    try {
      // Get a reference to the 'orders' collection in Firestore
      CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');

      // Fetch all documents from the 'orders' collection
      QuerySnapshot querySnapshot = await ordersCollection.get();

      // Process the documents and convert them to Orders objects
      List<Orders> ordersList = querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Convert the JSON data to an Orders object
        return Orders(
          contactname: data['contactname'],
          contactphone: data['contactphone'],
          total: data['Billedtotal'],
          mpesaname: data['mpesaname'],
          mpesnumber: data['mpesnumber'],
          mpesacode: data['mpesacode'],
          orderlist: data['orderlist'], // Assuming the data in Firestore is already in the correct format
        );
      }).toList();

      return ordersList;
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error fetching orders: $e');
      return [];
    }
  }
}
