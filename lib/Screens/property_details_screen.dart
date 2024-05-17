import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gharbhada/Screens/MapScreen.dart';
import 'package:gharbhada/features/auth/services/order_services.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:gharbhada/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class PropertyDetailsScreen extends StatelessWidget {
  static const String routeName = '/property-details';

  final Property property;

  const PropertyDetailsScreen({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                property.id!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    property.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MapPage(locationAddress: property.location),
                      ),
                    );
                  },
                ),
              ],
            ),
            CarouselSlider(
              items: property.images.map((image) {
                return Image.network(
                  image,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'PRICE: NPR.${property.price}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                property.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: CustomButton(
                  text: 'Buy Now',
                  onTap: () {
                    OrderServices().placeOrder(
                      context: context,
                      propertyID: property.id!,
                      userID: user!.id!,
                      status: 'pending',
                    );
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You have successfully booked ${property.name} property',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
