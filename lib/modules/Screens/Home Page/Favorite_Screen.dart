import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Shop/cubit.dart';
import 'package:shop_app/shared/cubit/Shop/states.dart';
import 'package:shop_app/shared/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context, state) {
       
     },
     builder: (context, state) {
       return Scaffold(
        body: ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              navigateto(context, DetailsProduct(products: ShopCubit.get(context).favorite!.data!.products[index],));
                            },
                            child: buildListProduct(
                              ShopCubit.get(context).favorite!.data!.products[index],
                              context,
                              isOldPrice: false,
                            ),
                          ),
                          separatorBuilder: (context, index) => Container(height: 1,width: double.infinity,),
                          itemCount:
                          ShopCubit.get(context).favorite!.data!.products.length,
                        ),
       );
     },
    );
  }

  Widget buildListProduct(
      model,
      context, {
        bool isOldPrice = true,
      }) => 
      Column(
        children: [
          if(model.in_favorites == true) Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 120.0,
              child: Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model.image),
                        width: 120.0,
                        height: 120.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            height: 1.3,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              model.price.toString(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: PrimaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                              },
                              icon: CircleAvatar(
                                radius: 15.0,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
