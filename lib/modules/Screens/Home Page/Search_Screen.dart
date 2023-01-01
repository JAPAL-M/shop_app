import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../../../shared/cubit/Search/cubit.dart';
import '../../../shared/cubit/Search/states.dart';
import '../../../shared/cubit/Shop/cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }

                        return null;
                      },
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).SearchDataget(text: text);
                      },
                      label: 'Search',
                      perfixicon: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchIsLoading) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccess)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              navigateto(context, DetailsProduct(products: SearchCubit.get(context).search!.data!.data[index],));
                            },
                            child: buildListProduct(
                              SearchCubit.get(context).search!.data!.data[index],
                              context,
                              isOldPrice: false,
                            ),
                          ),
                          separatorBuilder: (context, index) => Container(height: 1,width: double.infinity,),
                          itemCount:
                          SearchCubit.get(context).search!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListProduct(
      model,
      context, {
        bool isOldPrice = true,
      }) =>
      Padding(
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
      );
}