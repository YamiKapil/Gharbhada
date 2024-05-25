import 'package:flutter/material.dart';
import 'package:gharbhada/components/HomeCard.dart';
import 'package:gharbhada/features/auth/services/order_services.dart';
import 'package:gharbhada/features/auth/services/property_details_services.dart';
import 'package:gharbhada/features/auth/services/user_service.dart';
import 'package:gharbhada/models/order.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/models/user.dart';
import 'package:gharbhada/widgets/loader.dart';

class ProportyListings extends StatefulWidget {
  static const String routeName = '/property-listings';
  const ProportyListings({super.key});

  @override
  State<ProportyListings> createState() => _ProportyListingsState();
}

class _ProportyListingsState extends State<ProportyListings> {
  final OrderServices orderServices = OrderServices();
  final PropertyDetailsServices propertyDetailsServices =
      PropertyDetailsServices();
  final UserServices userServices = UserServices();

  List<Order>? orders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
    // fetchInfo(); //fetch property and user info
  }

  fetchOrder() async {
    orders = await orderServices.fetchOrder(context: context);
    // print('At My Order: ${orders![0].property![0].name}');
    // print('At My Order: ${orders.toString()}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      body: FutureBuilder(
        future: orderServices.fetchOrder(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Order> orders = snapshot.data as List<Order>;
            if (orders == null || orders.isEmpty) {
              return Center(
                child: Text('No orders found.'),
              );
            } else {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  if (orders[index].property != null &&
                      orders[index].property!.isNotEmpty) {
                    return HomeCard(
                      title: orders[index].property![0].name ?? '',
                      subtitle: orders[index].property![0].location ?? '',
                      image: orders[index].property![0].images != null &&
                              orders[index].property![0].images!.isNotEmpty
                          ? orders[index].property![0].images![0]
                          : '',
                      description: orders[index].property![0].description ?? '',
                      propertyImage:
                          orders[index].property![0].images != null &&
                                  orders[index].property![0].images!.isNotEmpty
                              ? orders[index].property![0].images![0]
                              : '',
                    );
                  } else {
                    return SizedBox(); // Return an empty SizedBox if the order is invalid
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}
