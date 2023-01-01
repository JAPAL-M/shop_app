import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Categories.dart';
import 'package:shop_app/models/Shop.dart';
import 'package:shop_app/modules/Screens/details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Shop/cubit.dart';
import 'package:shop_app/shared/cubit/Shop/states.dart';
import 'package:shop_app/shared/style/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state) => ConditionalBuilder(
            condition: ShopCubit.get(context).shop != null &&  ShopCubit.get(context).categories != null,
            builder: (context) => productBuilder(ShopCubit.get(context).shop,context,ShopCubit.get(context).categories),
            fallback: (context) => Center(child: CircularProgressIndicator())
        ),
    );
  }

  Widget productBuilder(ShopClass? shop,context,CategoriesModel? categories) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CarouselSlider(
          items: shop!.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList(),
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: Duration(seconds: 3),
            scrollDirection: Axis.horizontal
          )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Categories',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => buildCategoriesItem(categories.data!.data[index]),
                    separatorBuilder: (context,index) => SizedBox(width: 10,),
                    itemCount: categories!.data!.data.length
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'New Product',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.58,
          children: List.generate(shop.data!.products.length, (index) => GestureDetector(
            onTap: () {
              navigateto(context, DetailsProduct(products: shop.data!.products[index]));
            },
            child: buildGridView(shop.data!.products[index],context))),
        ),
        ),
      ],
    ),
  );

  Widget buildCategoriesItem(DataCat model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image.toString()),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.8),
        child: Text(
          model.name.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
      )
    ],
  );

  Widget buildGridView(ProductsData products,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${products.image}'),
              width: double.infinity,
              height: 200,
            ),
            if(products.discount != 0)
             Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 12),),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                products.name.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                ),),
              Row(
                children: [
                  Text(
                    products.price.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: PrimaryColor,
                    ),),
                  SizedBox(width: 5,),
                  Text(
                    products.discount.toString() == '0' ? '' : products.discount.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.all(0),
                      onPressed: (){
                        ShopCubit.get(context).AddFavorite(id: products.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[products.id] == true ? PrimaryColor :  Colors.grey,
                        child: 
                        Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,)
                          )
                          )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
