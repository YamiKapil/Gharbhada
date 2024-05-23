import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharbhada/Screens/select_map_location.dart';
import 'package:gharbhada/components/myListTile.dart';
import 'package:gharbhada/components/myTextField.dart';
import 'package:gharbhada/constants/utils.dart';
import 'package:gharbhada/features/auth/services/admin_services.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:gharbhada/widgets/custom_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class AddProperty extends StatefulWidget {
  static const String routeName = '/add-property';

  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController latLong = TextEditingController();
  LatLng? latlongstatic;

  final AdminServices adminServices = AdminServices();

  List<File> images = [];
  final _addPropertyFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    propertyNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    latLong.dispose();
  }

  void sellProperty() {
    if (_addPropertyFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProperty(
          context: context,
          name: propertyNameController.text,
          location: locationController.text,
          price: priceController.text,
          latLong: latLong.text,
          description: descriptionController.text,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List New Property",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "List in the market where renter are waiting!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Larger account icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // or any other color you prefer
                    ),
                    child: Icon(
                      Icons.person,
                      size: 24, // or any other size you prefer
                      color: Colors.grey[600], // or any other color you prefer
                    ),
                  ),
                  SizedBox(width: 10), // Add spacing between icon and text
                  // Username and email aligned vertically
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height:
                              4), // Add vertical spacing between name and email
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: _addPropertyFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: propertyNameController,
                        hintText: "Property Name"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: locationController, hintText: "Location"),
                    const SizedBox(height: 10),
                    // CustomTextField(controller: latLong, hintText: "LatLong"),
                    TextFormField(
                      controller: latLong,
                      decoration: InputDecoration(
                          hintText: 'LatLong',
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black38,
                          )),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black38,
                          ))),
                      readOnly: true,
                      onTap: () async {
                        final LatLng? data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectLocationMaps(
                              latlng: latlongstatic,
                            ),
                          ),
                        );
                        log(data.toString());
                        if (data != null) {
                          latlongstatic = data;
                          latLong.text = "${data.latitude},${data.longitude}";
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: priceController, hintText: "Price"),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(Icons.add_a_photo,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    CustomButton(text: "Add Property", onTap: sellProperty),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
