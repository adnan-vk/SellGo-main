import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/category_page/category.dart';
import 'package:authentication/view/details/details.dart';
import 'package:authentication/view/notification/notification.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:authentication/widgets/text_widget.dart';
import 'package:authentication/widgets/textfield_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/circleavatar_widget.dart';

class HomeWidgets {
  final firebseauth = FirebaseAuth.instance.currentUser;
  ImageProvider? imageprovider;
  topwidget(context) {
    final size = MediaQuery.of(context).size;
    if (firebseauth != null && firebseauth!.photoURL != null) {
      imageprovider = NetworkImage(
        firebseauth!.photoURL.toString(),
      );
    } else {
      imageprovider = AssetImage("assets/images/default image.jpg");
    }
    return Row(
      children: [
        circleavatar().circleAvatar(
          image: imageprovider,
          context: context,
          radius: 20.0,
        ),
        SizedBox(
          width: size.width * .02,
        ),
        Expanded(
          child: textFormField().searchtextfield(
            context: context,
            preicon: EneftyIcons.search_normal_2_outline,
            label: "Search",
          ),
        ),
        SizedBox(
          width: size.width * .02,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 5,
          ),
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              borderRadius: BorderRadius.circular(5),
            ),
            badgeContent:
                TextWidget().text(data: "1", size: 9.0, color: Colors.white),
            child: GestureDetector(
              onTap: () => NavigatorHelper().push(
                context: context,
                page: NotificationScreen(),
              ),
              child: Icon(
                EneftyIcons.notification_bold,
                color: colors().blue,
              ),
            ),
          ),
        )
      ],
    );
  }

  categoryAvatarListView(context) {
    final size = MediaQuery.of(context).size;
    final List<String> catorgoryName = [
      "Computer",
      "MobilePhones",
      "Electronics",
      "HomeAppliances",
      "Vehicles",
      "Jobs",
      "Others"
    ];
    final List<Object> catorgoryItems = [
      NetworkImage(
          'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Gaming-laptops._CB574550011_.png'),
      NetworkImage(
          'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Tablets._CB574550011_.png'),
      NetworkImage(
          'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Computer-Accessories._CB574550011_.png'),
      AssetImage('assets/images/category_images/home appliances.png'),
      AssetImage('assets/images/category_images/vehicle 2.png'),
      AssetImage('assets/images/category_images/jobs.jpg'),
      NetworkImage(
          'https://m.media-amazon.com/images/G/31/img23/CEPC/BAU/ELP/navtiles/Tablets._CB574550011_.png'),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          catorgoryName.length * 2 - 1,
          (index) {
            if (index.isEven) {
              int categoryIndex = index ~/ 2;
              return circleavatar().categoryavatar(
                page: Category(
                  category: catorgoryName[categoryIndex],
                ),
                context: context,
                text: catorgoryName[categoryIndex],
                child: Image(
                    image: catorgoryItems[categoryIndex] as ImageProvider),
              );
            } else {
              return SizedBox(
                width: size.width * .03,
              );
            }
          },
        ),
      ),
    );
  }

  productList(context) {
    final pro = Provider.of<ItemProvider>(context, listen: false);
    final authpro = Provider.of<AuthenticationProvider>(context, listen: false);
    bool? thisuser;
    pro.getProduct();
    final size = MediaQuery.of(context).size;
    int crossAxisCount = (size.width / 200).floor();
    if (crossAxisCount < 2) {
      crossAxisCount = 2;
    }
    return Expanded(
      child: Consumer<ItemProvider>(
        builder: (context, value, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: value.searchlist.isNotEmpty
              ? value.searchlist.length
              : value.allproducts.length,
          itemBuilder: (context, index) {
            final product = value.searchlist.isNotEmpty
                ? value.searchlist[index]
                : value.allproducts[index];
            return GestureDetector(
              onTap: () async {
                if (product.uid == firebseauth!.uid) {
                  thisuser = true;
                } else {
                  thisuser = false;
                }
                await authpro.getProductUser(product.uid!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      thisUser: thisuser!,
                      product: product,
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              product.image != null
                                  ? product.image![0]
                                  : 'assets/images/dummy image.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: colors().blue,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/dummy image.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .005,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: TextWidget().text(
                                    data: "₹ ${product.price}",
                                    size: 20.0,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final wish = value.favListCheck(product);
                                    await value.favouritesClicked(
                                        product.id!, wish);
                                  },
                                  child: value.favListCheck(product)
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
                              ],
                            ),
                          ),
                          TextWidget().text(
                            data: product.productname,
                            size: 13.0,
                          ),
                          SizedBox(height: size.height * .005),
                          TextWidget().text(
                              data: product.place,
                              size: 11.0,
                              color: Colors.grey,
                              weight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
