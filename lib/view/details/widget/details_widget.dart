// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DetailWidget {
//   showLargeImage(String imageUrl, context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.contain,
//           ),
//         );
//       },
//     );
//   }

//   buildDot(int index, context) {
//     final pro = Provider.of(context, listen: false);
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 4.0),
//       child: Container(
//         width: 8,
//         height: 8,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: pro.selectedImageIndex == index ? Colors.blue : Colors.grey,
//         ),
//       ),
//     );
//   }
// }
