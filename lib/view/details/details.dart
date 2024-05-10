// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/call/call.dart';
import 'package:authentication/view/chatpage/chat.dart';
import 'package:authentication/view/details/razorpay/razerpay.dart';
import 'package:authentication/view/details/widget/details_widget.dart';
import 'package:authentication/view/location/location.dart';
import 'package:authentication/widgets/circleavatar_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
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
          widget.thisUser!
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    NavigatorHelper()
                        .push(context: context, page: CallingPage());
                  },
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
                      DetailWidget().showLargeImage(
                          widget.product.image![index], context);
                    },
                    child: Image.network(
                      widget.product.image![index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    selectedImageIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.image!.length,
                (index) => DetailWidget().buildDot(index),
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
                widget.thisUser!
                    ? SizedBox.shrink()
                    : ElevatedButton(
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.product.category.toString()),
            SizedBox(height: 10),
            Text(widget.product.description.toString()),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Consumer<AuthenticationProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      circleavatar().circleAvatar(
                        image: NetworkImage(
                            value.sortedUser?.image.toString() ?? ""),
                        bgcolor: Colors.black,
                        context: context,
                        radius: 25.0,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                TextWidget().text(
                                  data: value.sortedUser!.firstname,
                                  size: 17.0,
                                ),
                                SizedBox(
                                  width: size.width * .5,
                                  child: TextWidget().text(
                                    data: value.sortedUser!.email,
                                    size: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextWidget().text(
                                  data: value.sortedUser?.phoneNumber,
                                  size: 14.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            widget.thisUser!
                                ? SizedBox.shrink()
                                : IconButton(
                                    onPressed: () => NavigatorHelper().push(
                                      context: context,
                                      page:
                                          ChatPage(userinfo: pro.currentUser!),
                                    ),
                                    icon: Icon(EneftyIcons.message_outline),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            widget.thisUser!
                ? SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RazorpayAmountScreen(),
                        ),
                      );
                    },
                    child: Text("Proceed to Payment"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: colors().blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
