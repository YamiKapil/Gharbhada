import 'package:flutter/material.dart';

import 'package:gharbhada/Screens/AddProperty.screen.dart';
import 'package:gharbhada/Screens/Admin.screen.dart';
import 'package:gharbhada/Screens/AdminSignIn.dart';

import 'package:gharbhada/Screens/EditProfile.dart';

import 'package:gharbhada/Screens/Home.screen.dart';
import 'package:gharbhada/Screens/MyOrder.dart';
import 'package:gharbhada/Screens/ProfilePage.screen.dart';
import 'package:gharbhada/Screens/SignIn.screen.dart';
import 'package:gharbhada/Screens/SignUp.screen.dart';
import 'package:gharbhada/Screens/property_details_screen.dart';
import 'package:gharbhada/Screens/search_screen.dart';
import 'package:gharbhada/main.dart';
import 'package:gharbhada/models/property.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignIn.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignIn(),
      );

    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );

    case Gharbhada.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Gharbhada(
          key: const Key('gharbhada'),
        ),
      );

    case ProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProfilePage(),
      );

    case EditProfile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditProfile(),
      );

    case SignUp.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUp(),
      );

    case ProportyListings.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProportyListings(),
      );
    case AddProperty.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProperty(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case PropertyDetailsScreen.routeName:
      var property = routeSettings.arguments as Property;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PropertyDetailsScreen(
          property: property,
        ),
      );

    case AdminSignIn.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminSignIn(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('No Screen Error'),
          ),
        ),
      );
  }
}
