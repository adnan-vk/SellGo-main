import 'package:flutter/material.dart';

int selectedImageIndex = 0;

class DetailWidget {
  void showLargeImage(String imageUrl, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedImageIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
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
}
