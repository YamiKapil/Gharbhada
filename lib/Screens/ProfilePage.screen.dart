import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/EditProfile.dart';
import 'package:gharbhada/Screens/PrivacyScreen.dart';
import 'package:gharbhada/Screens/ProfileDetails.dart';
import 'package:gharbhada/Screens/SignIn.screen.dart';
import 'package:gharbhada/components/MyProfileCard.dart';
import 'package:gharbhada/components/myListTile.dart';
import 'package:gharbhada/components/profileListTiles.dart';
import 'package:gharbhada/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  Future<void> _logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth-token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            MyProfileCard(user.name, "assets/images/profile.png", user.email),
            SizedBox(height: 30),
            ProfileActionButton(
              title: "Personal Details",
              leadingIcon: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPersonalDetailsPage()));
              },
            ),
            ProfileActionButton(
              title: "Edit Details",
              leadingIcon: Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, EditProfile.routeName);
              },
            ),
            ProfileActionButton(
              title: "Privacy and Safety",
              leadingIcon: Icon(Icons.lock),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacySafetyPage()));
              },
            ),
            ProfileActionButton(
              title: "My Order",
              leadingIcon: Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.pushNamed(context, '/property-listings');
              },
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () => _logOut(context),
              child: Center(
                child: Text("Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
