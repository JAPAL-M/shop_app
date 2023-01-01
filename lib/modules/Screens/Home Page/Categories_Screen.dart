import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Categories.dart';
import 'package:shop_app/shared/cubit/Shop/cubit.dart';
import 'package:shop_app/shared/cubit/Shop/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildCategories(context,ShopCubit.get(context).categories!.data!.data[index]),
                separatorBuilder: (context,index) => Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
                itemCount: ShopCubit.get(context).categories!.data!.data.length
            )
        );
      },
    );
  }

  Widget buildCategories(context,DataCat model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image.toString()),
          height: 100,
          width: 100,
        ),
        SizedBox(width: 20,),
        Text(model.name.toString(),style: Theme.of(context).textTheme.bodyText1,),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.navigate_next,size: 30,))
      ],
    ),
  );
}
