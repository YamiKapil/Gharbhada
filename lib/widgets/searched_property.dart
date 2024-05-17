import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/property_details_screen.dart';
import 'package:gharbhada/models/property.dart';

class SearchedProperty extends StatelessWidget {
  final Property property;
  const SearchedProperty({
    Key? key,
    required this.property,
  }) : super(key: key);

  navigateToPropertyDetails(BuildContext context) {
    Navigator.pushNamed(context, PropertyDetailsScreen.routeName,
        arguments: property);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPropertyDetails(context);
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Image.network(
                  property.images[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        property.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\Rs.${property.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(property.description),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
