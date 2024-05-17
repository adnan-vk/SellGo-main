// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/view/details/payment/payment.dart';
import 'package:authentication/view/details/widget/details_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  bool? thisUser;
  final ProductModel product;

  Details({
    Key? key,
    required this.product,
    required this.thisUser,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Product Details',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          if (!widget.thisUser!)
            IconButton(
              icon: Icon(Icons.chat_bubble_outline,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => NavigatorHelper().push(
                context: context,
                page: ChatPage(userinfo: pro.sortedUser!),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 223, 242, 248)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: size.height * 0.4,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                    ),
                    items: widget.product.image!
                        .map((imageUrl) => GestureDetector(
                              onTap: () {
                                DetailWidget()
                                    .showLargeImage(imageUrl, context);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.image!.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentImageIndex == index
                                ? colors().blue
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹ ${widget.product.price.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 40, 126, 89),
                                ),
                              ),
                              Icon(
                                EneftyIcons.heart_outline,
                                color: Colors.red,
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${widget.product.productname!.toUpperCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          SizedBox(height: 10),
                          Text(
                            "Product Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.product.description.toString(),
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(pro.sortedUser?.image ?? ""),
                            radius: 25,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pro.sortedUser!.firstname.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                pro.sortedUser!.email.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DetailWidget().launchPhone(
                                      "${pro.sortedUser?.phoneNumber}");
                                },
                                child: Text(
                                  pro.sortedUser?.phoneNumber ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (!widget.thisUser!)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Text(
                            "Proceed to Payment",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          // shadowColor: Colors.greenAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
