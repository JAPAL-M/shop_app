import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/models/Search.dart';
import 'package:shop_app/models/Shop.dart';

class DetailsProduct extends StatelessWidget {
   DetailsProduct({super.key,this.products});

    dynamic products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: NetworkImage(products.image.toString()),width: double.infinity,height: 250,),
            SizedBox(height: 20,),
            Text(products.description.toString()),
          ],
        ),
      ),
    );
  }
}