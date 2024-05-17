import 'package:flutter/material.dart';
import 'package:gharbhada/constants/globalvariables.dart';
import 'package:gharbhada/features/auth/services/search_services.dart';
import 'package:gharbhada/models/property.dart';
import 'package:gharbhada/widgets/loader.dart';
import 'package:gharbhada/widgets/searched_property.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;
  SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Property>? properties;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProperty();
  }

  fetchSearchedProperty() async {
    properties = await searchServices.fetchSearchedProperty(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: properties == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: properties!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   ProductDetailScreen.routeName,
                          //   arguments: products![index],
                          // );
                        },
                        child: SearchedProperty(
                          property: properties![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
