// ignore_for_file: must_be_immutable

import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/view/details/call/call.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/view/details/payment/payment.dart';
import 'package:authentication/view/details/location/location.dart';
import 'package:authentication/view/details/widget/details_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
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
  int selectedImageIndex = 0;

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
          icon: Icon(EneftyIcons.arrow_left_3_outline, color: Colors.black),
        ),
        // actions: [
        //   widget.thisUser!
        //       ? SizedBox.shrink()
        //       : IconButton(
        //           onPressed: () {
        //             NavigatorHelper()
        //                 .push(context: context, page: CallingPage());
        //           },
        //           icon: Icon(EneftyIcons.call_calling_outline,
        //               color: Colors.black),
        //         ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * .35,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: widget.product.image!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        DetailWidget().showLargeImage(
                            widget.product.image![index], context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\₹ ${widget.product.price.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red,
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
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                elevation: 0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Consumer<AuthenticationProvider>(
                    builder: (context, value, child) => Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              value.sortedUser?.image.toString() ?? ""),
                          radius: 25.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.sortedUser!.firstname.toString(),
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                value.sortedUser!.email.toString(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DetailWidget().launchPhone(
                                      "${value.sortedUser?.phoneNumber}");
                                },
                                child: Text(
                                  value.sortedUser?.phoneNumber ?? '',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.thisUser!
                            ? SizedBox.shrink()
                            : IconButton(
                                onPressed: () => NavigatorHelper().push(
                                  context: context,
                                  page: ChatPage(userinfo: pro.sortedUser!),
                                ),
                                icon: Icon(EneftyIcons.message_outline,
                                    color: Colors.black),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Category: ${widget.product.category}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                widget.product.description.toString(),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              widget.thisUser!
                  ? SizedBox.shrink()
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      },
                      child: Text("Proceed to Payment"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
