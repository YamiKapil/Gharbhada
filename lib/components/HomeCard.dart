import 'package:flutter/material.dart';

// Container HomeCard(String image, String title, String subtitle,
//     String description, String propertyImage) {
//   return Container(
//     decoration: BoxDecoration(
//         color: Color.fromARGB(143, 232, 233, 233),
//         borderRadius: BorderRadius.all(Radius.circular(10))),
//     child: Column(
//       children: [
//         SizedBox(
//           height: 30,
//           child: ListTile(
//             leading: Image(
//               image: AssetImage(image),
//             ),
//             title: Text(title),
//             subtitle: Text(subtitle),
//           ),
//         ),
//         SizedBox(height: 28),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             description,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         SizedBox(
//           height: 150,
//           child: Image(image: AssetImage(propertyImage)),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     ),
//   );
// }

class HomeCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String propertyImage;
  const HomeCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.propertyImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Use a light gray background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16), // Add padding for content spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(subtitle),
          ),
          SizedBox(height: 16), // Add spacing between ListTile and description
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800], // Use a darker gray color for text
            ),
          ),
          SizedBox(height: 16), // Add spacing between description and image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              propertyImage,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
