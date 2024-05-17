// import 'package:flutter/material.dart';
// import 'package:gharbhada/features/auth/services/order_services.dart';
// // Import your OrderServices
// import 'package:provider/provider.dart'; // Import Provider for accessing OrderServices

// import 'package:gharbhada/models/order.dart';

// class OrdersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       body: FutureBuilder<List<Order>>(
//         future: OrderServices().fetchAllOrders(context),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No orders available'),
//             );
//           } else {
//             List<Order> orders = snapshot.data!;
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   elevation: 4,
//                   child: ListTile(
//                     title: Text('Order ID: ${orders[index].id}'),
//                     subtitle: Text('Amount: ${orders[index].property}'),
//                     // Add more fields as needed
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
