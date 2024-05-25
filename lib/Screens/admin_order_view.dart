import 'package:flutter/material.dart';
import 'package:gharbhada/features/auth/services/admin_services.dart';
import 'package:gharbhada/features/auth/services/chat_service.dart';
import 'package:gharbhada/features/auth/services/notification_service.dart';
import 'package:gharbhada/features/auth/services/order_services.dart';
import 'package:gharbhada/models/admin_order.dart';
import 'package:gharbhada/models/order.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:gharbhada/widgets/ordertile.dart';
import 'package:provider/provider.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  List<AdminOrder>? orders;
  final OrderServices orderServices = OrderServices();
  final AdminServices adminServices = AdminServices();
  final ChatService chatService = ChatService();
  final NotificationServices notificationServices = NotificationServices();

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
  void confirmOrDeleteOrder(
      int index, bool isConfirm, BuildContext context, Property property) {
    if (isConfirm) {
      orderServices.updateOrderStatus(
          context: context,
          status: 'completed',
          orderID: orders![index].id.toString());
      sendMessage(
        context,
        'Order id ${orders![index].property?.id ?? ''} accepted successfully. Pay Now',
        orders![index].userID,
        '',
      );
      postNotification(
        context,
        property,
        'Order id ${orders![index].property?.id ?? ''} accepted successfully.',
        index,
      );
      deleteProduct(
        property,
      );
    } else {
      orderServices.updateOrderStatus(
          context: context,
          status: 'rejected',
          orderID: orders![index].id.toString());
      sendMessage(
        context,
        'Order id ${orders![index].property?.id ?? ''} rejected',
        orders![index].userID,
        '',
      );
      postNotification(
        context,
        property,
        'Order id ${orders![index].property?.id ?? ''} rejected',
        index,
      );
    }
    // Refresh orders list after updating order status
    fetchAllOrders();
  }

  void deleteProduct(Property property) {
    adminServices.deleteProperty(
      context: context,
      property: property,
      onSuccess: () {
        setState(() {});
      },
    );
  }

  void sendMessage(
    BuildContext context,
    String text,
    String userId,
    String userName,
  ) async {
    final userInfo = Provider.of<UserProvider>(context, listen: false).user;

    await chatService.sendMessage(
      message: text,
      receiverId: userId,
      receiverName: userName,
      senderId: userInfo.id,
      senderName: userInfo.name,
    );
  }

  postNotification(BuildContext context, Property property, String message,
      int index) async {
    final userInfo = Provider.of<UserProvider>(context, listen: false).user;
    await notificationServices.postNotification(
      context: context,
      description: property.description,
      userID: userInfo.id,
      status: orders?[index].status ?? '',
      images: property.images,
      latLong: property.latLong,
      location: property.location,
      message: message,
      name: property.name,
      price: property.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Order Screen'),
      ),
      body: FutureBuilder<List<AdminOrder>>(
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
                    // title: orders![index].property![0].name,
                    // subtitle: orders![index].property![0].price,
                    // title: orders![index].property![0].name,
                    // subtitle: orders![index].property![0].price,
                    title: orders![index].property?.name ?? 'test',
                    subtitle: orders![index].property?.price ?? 'test',
                    onConfirm: () {
                      confirmOrDeleteOrder(
                          index, true, context, orders![index].property!);
                    },
                    onDelete: () {
                      confirmOrDeleteOrder(
                          index, false, context, orders![index].property!);
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
