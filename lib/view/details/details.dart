// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/view/details/payment/payment.dart';
import 'package:authentication/view/details/widget/details_widget.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
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
        title: TextWidget().text(data: "Product Details"),
        automaticallyImplyLeading: false,
        leading: ButtonWidget().leadingIcon(context),
        actions: [
          if (!widget.thisUser!)
            IconButton(
              icon: Icon(
                EneftyIcons.message_2_outline,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
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
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
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
                              TextWidget().text(
                                data: "₹ ${widget.product.price.toString()}",
                                size: 24.0,
                                weight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 126, 89),
                              ),
                              Consumer<ItemProvider>(
                                builder: (context, value, child) => InkWell(
                                  onTap: () async {
                                    final wish =
                                        value.favListCheck(widget.product);
                                    await value.favouritesClicked(
                                        widget.product.id!, wish);
                                  },
                                  child: value.favListCheck(widget.product)
                                      ? Icon(
                                          EneftyIcons.heart_outline,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          EneftyIcons.heart_bold,
                                          color: Colors.red,
                                        ),
                                  borderRadius: BorderRadius.circular(50.0),
                                  splashColor: Colors.grey.withOpacity(0.3),
                                  highlightColor: Colors.red.withOpacity(0.1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextWidget().text(
                              data: widget.product.productname!.toUpperCase(),
                              weight: FontWeight.bold,
                              size: 14.0),
                          SizedBox(height: 15),
                          Divider(),
                          SizedBox(height: 10),
                          TextWidget().text(
                            data: "Product Details",
                            weight: FontWeight.bold,
                            size: 18.0,
                          ),
                          SizedBox(height: 10),
                          TextWidget().text(
                              data: widget.product.description.toString(),
                              size: 16.0,
                              color: Colors.black54)
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
                              TextWidget().text(
                                  data:
                                      "${pro.sortedUser?.firstname.toString() ?? ""}",
                                  weight: FontWeight.bold,
                                  size: 16.0),
                              SizedBox(height: 5),
                              TextWidget().text(
                                data:
                                    "${pro.sortedUser?.email.toString() ?? ""}",
                                size: 14.0,
                                color: Colors.grey,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DetailWidget().launchPhone(
                                      "${pro.sortedUser?.phoneNumber} ??" " ");
                                },
                                child: TextWidget().text(
                                  data: pro.sortedUser?.phoneNumber ?? '',
                                  size: 14.0,
                                  color: Colors.blue,
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
                          child: TextWidget().text(
                            data: "Proceed to Payment",
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
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
