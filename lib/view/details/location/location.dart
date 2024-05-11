import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class ProductLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            'https://100map.net/img/en/a2p_london.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          height: 170,
          left: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              EneftyIcons.arrow_circle_left_outline,
            ),
          ),
        ),
      ],
    ));
  }
}
