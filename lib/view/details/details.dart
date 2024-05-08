import 'package:authentication/view/chatpage/chat.dart';
import 'package:authentication/view/location/location.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:flutter/material.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/view/details/razorpay/razerpay.dart';
import 'package:enefty_icons/enefty_icons.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            NavigatorHelper().pop(context: context);
          },
          icon: Icon(EneftyIcons.arrow_left_3_outline),
        ),
        actions: [
          IconButton(
            onPressed: () => NavigatorHelper().push(
              context: context,
              page: ChatPage(),
            ),
            icon: Icon(EneftyIcons.message_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(EneftyIcons.call_calling_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: widget.product.image!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showLargeImage(widget.product.image![index]);
                    },
                    child: Image.network(
                      widget.product.image![index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.image!.length,
                (index) => buildDot(index),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product.productname!.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductLocationPage(),
                      ),
                    );
                  },
                  child: Text("Location"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.product.category.toString()),
            SizedBox(height: 10),
            Text(widget.product.description.toString()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RazorpayAmountScreen(),
                  ),
                );
              },
              child: Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
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
          color: _selectedImageIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  void _showLargeImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
        );
      },
    );
  }
}
