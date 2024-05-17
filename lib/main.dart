import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/AddProperty.screen.dart';
import 'package:gharbhada/Screens/Admin.screen.dart';
import 'package:gharbhada/Screens/ChatApp.dart';
import 'package:gharbhada/Screens/MapScreen.dart';
import 'package:gharbhada/Screens/OTP.screen.dart';
import 'package:gharbhada/Screens/ProfilePage.screen.dart';
import 'package:gharbhada/Screens/Search.screen.dart';
import 'package:gharbhada/Screens/SearchScreen.dart';
import 'package:gharbhada/Screens/SignIn.screen.dart';
import 'package:gharbhada/Screens/SignUp.screen.dart';
import 'package:gharbhada/Screens/Home.screen.dart';
import 'package:gharbhada/Screens/search_screen.dart';
import 'package:gharbhada/Screens/splash.screen.dart';
import 'package:gharbhada/features/auth/services/auth_service.dart';
import 'package:gharbhada/getStarted.dart';
import 'package:gharbhada/router.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[600], // Set primary color to gray
        hintColor: Colors.grey[600], // Set accent color to gray
        scaffoldBackgroundColor:
            Colors.grey[200], // Set scaffold background color to light gray
        // You can customize more theme properties here
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? Gharbhada(
                  key: const Key('gharbhada'),
                )
              : const AdminScreen()
          : GetStartedPage(),
    );
  }
}

class Gharbhada extends StatefulWidget {
  const Gharbhada({required Key key}) : super(key: key);
  static const String routeName = '/gharbhada';

  @override
  State<Gharbhada> createState() => _GharbhadaState();
}

class _GharbhadaState extends State<Gharbhada> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => setState(() {
          currentPageIndex = value;
        }),
        indicatorColor: const Color.fromARGB(255, 11, 110, 191),
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.map),
          //   label: 'Add Property',
          // ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: [
        const HomePage(),
        const HomePageS(),
        // const AddProperty(),
        ChatScreen(),
        // SearchPage(),
        // AddProperty(),
        ProfilePage(),
      ][currentPageIndex],
    );
  }
}
