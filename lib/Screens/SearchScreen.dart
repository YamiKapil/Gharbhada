import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharbhada/Screens/property_details_screen.dart';
import 'package:gharbhada/Screens/search_screen.dart';
import 'package:gharbhada/components/HomeCard.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/features/auth/services/home_services.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:gharbhada/widgets/loader.dart';
import 'package:provider/provider.dart';

class HomePageS extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomePageS({super.key});

  @override
  State<HomePageS> createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
  final HomeServices homeServices = HomeServices();
  List<Property>? propertyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProperty();
  }

  fetchProperty() async {
    propertyList = await homeServices.fetchProperty(context: context);
    print('Fetched properties: $propertyList');
    setState(() {});
  }

  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  navigateToPropertyDetails(property) {
    Navigator.pushNamed(context, PropertyDetailsScreen.routeName,
        arguments: property);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Welcome to Ghar Bhada",
      //     style: TextStyle(fontSize: 20),
      //   ),
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Properties',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: propertyList == null
          ? Loader()
          : propertyList!.length == 0
              ? Center(
                  child: Text("Oops ! No Properties available currently. "),
                )
              : ListView.builder(
                  itemCount: propertyList!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToPropertyDetails(propertyList![index]);
                      },
                      child: HomeCard(
                        image: "assets/images/profile.png",
                        title: propertyList![index].name,
                        subtitle: propertyList![index].location,
                        description: propertyList![index].description,
                        propertyImage: propertyList![index].images.isNotEmpty
                            ? propertyList![index].images[0]
                            : "https://www.houselogic.com/wp-content/uploads/2016/08/property-tax-appeal-retina_retina_9f661fd354bfde92b764d39542dfee75.jpg?crop&resize=2560%2C1706",
                      ),
                    );
                  },
                ),
      // Text(user.toJson()),
    );
  }
}
