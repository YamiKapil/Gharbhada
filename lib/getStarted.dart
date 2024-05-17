import 'package:flutter/material.dart';
import 'package:gharbhada/Screens/SignIn.screen.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/backgroundimage.jpeg', // Replace with your background image path
            fit: BoxFit.cover,
          ),
          const Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Positioned(
                top: 100.0, // Adjust the top position as needed
                left: 20.0, // Adjust the left position as needed
                child: Text(
                  'GharBhada: We are  Where ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,

                    //italic
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Positioned(
                top: 40.0, // Adjust the top position as needed
                left: 20.0, // Adjust the left position as needed
                child: Text(
                  ' Want to Live',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40.0,
                left: 20,
                right: 20,
              ),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Add navigation logic here
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
