import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/AddProperty.screen.dart';
import 'package:gharbhada/features/auth/services/admin_services.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/widgets/loader.dart';
import 'package:gharbhada/widgets/single_product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Property>? properties;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProperties();
  }

  fetchAllProperties() async {
    properties = await adminServices.fetchAllProperties(context);
    setState(() {});
  }

  void deleteProduct(Property property, int index) {
    adminServices.deleteProperty(
      context: context,
      property: property,
      onSuccess: () {
        properties!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProperty() {
    Navigator.pushNamed(context, AddProperty.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // Check if the properties list is null or empty
    if (properties == null || properties!.isEmpty) {
      // Return a loader or a message indicating that there are no properties
      return const Loader(); // or any other widget
    }

    return Scaffold(
      body: GridView.builder(
        itemCount: properties!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final propertydata = properties![index];
          return Column(
            children: [
              SizedBox(
                height: 140,
                child: SingleProduct(
                  image: propertydata.images.isNotEmpty
                      ? propertydata.images[0]
                      : "https://www.houselogic.com/wp-content/uploads/2016/08/property-tax-appeal-retina_retina_9f661fd354bfde92b764d39542dfee75.jpg?crop&resize=2560%2C1706",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      propertydata.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => deleteProduct(propertydata, index),
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProperty,
        child: const Icon(Icons.add),
        tooltip: 'Add a Property',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
