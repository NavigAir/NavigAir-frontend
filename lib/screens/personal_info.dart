// import 'package:flutter/material.dart';

// class PersonalInfoScreen extends StatelessWidget {
//   final String name;
//   final String passport;
//   final String imageAsset; // Path to the avatar image asset
//   final int age; // User's age
//   final double vision; // Vision capacity as a percentage

//   // PersonalInfoScreen(
//   // //   {
//   // //   required this.name,
//   // //   required this.passport,
//   // //   required this.imageAsset,
//   // //   required this.age,
//   // //   required this.vision,
//   // // }
//   // );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Personal Info'),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey), // Border to simulate an ID card
//             borderRadius: BorderRadius.circular(10.0), // Rounded corners
//             color: Colors.white, // Background color for the ID card
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 40.0, // Avatar size
//                 backgroundImage: AssetImage(imageAsset), // Load the avatar image
//               ),
//               SizedBox(width: 20.0), // Space between the avatar and the text
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
//                 children: [
//                   Text(
//                     'Name: $name',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10.0), // Space between text elements
//                   Text(
//                     'Passport: $passport',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.black54, // Softer text color
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     'Age: $age',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     'Vision Capacity: ${vision.toStringAsFixed(1)}%', // Rounded to one decimal
//                     style: TextStyle(
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
