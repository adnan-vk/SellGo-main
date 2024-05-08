import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/favourites/widget/fav_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_widget.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextWidget().text(data: "Favourites", color: colors().black),
        centerTitle: true,
      ),
      body: favWidget().buildFavouriteItem(context),
    );
  }
}
