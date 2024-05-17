import 'package:flutter/material.dart';
import 'package:gharbhada/features/auth/services/order_services.dart';
import 'package:gharbhada/models/order.dart';
import 'package:gharbhada/widgets/ordertile.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  List<Order>? orders;
  final OrderServices orderServices = OrderServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  // Function to fetch all orders
  Future<void> fetchAllOrders() async {
    orders = await orderServices.fetchAllOrders(context);
    setState(() {});
  }

  // Function to confirm or delete order
  void confirmOrDeleteOrder(int index, bool isConfirm, BuildContext context) {
    if (isConfirm) {
      orderServices.updateOrderStatus(
          context: context,
          status: 'completed',
          orderID: orders![index].id.toString());
    } else {
      orderServices.updateOrderStatus(
          context: context,
          status: 'rejected',
          orderID: orders![index].id.toString());
    }
    // Refresh orders list after updating order status
    fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Order Screen'),
      ),
      body: FutureBuilder<List<Order>>(
        future: orderServices.fetchAllOrders(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while the future is loading
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there is an error in fetching the data
            return Center(child: Text('Failed to fetch orders.'));
          } else {
            // Handle the case where data is loaded successfully
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              // Display a message if there are no orders available
              return Center(child: Text('No orders available.'));
            }

            // Assign the loaded orders data to the orders list
            orders = snapshot.data;

            // Return a ListView of order tiles
            return ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                // Ensure index is valid before accessing the orders list
                if (index < orders!.length) {
                  return OrderTile(
                    index: index,
                    title: orders![index].property![0].name,
                    subtitle: orders![index].property![0].price,
                    onConfirm: () {
                      confirmOrDeleteOrder(index, true, context);
                    },
                    onDelete: () {
                      confirmOrDeleteOrder(index, false, context);
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
