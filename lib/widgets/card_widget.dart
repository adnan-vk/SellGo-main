import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CardWidget {
  card({url, text, VoidCallback? ontap, required context}) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 238, 237, 237),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * .07,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: size.width * .12),
            Expanded(
              child: TextWidget().text(
                data: text,
                size: size.width * .045,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
