import 'dart:convert';

import 'package:assignment/constants/data_constants.dart';
import 'package:assignment/screens/checkout/views/checkout_screen.dart';
import 'package:assignment/screens/item_list/bloc/add_to_cart_bloc.dart';
import 'package:assignment/screens/item_list/model/item_model.dart';
import 'package:assignment/widgets/add_item_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {

    List<ItemModel> list = itemModelFromJson(jsonEncode(DataConstants.listData));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Salad & Soups"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 17),
        child: Stack(
          children: [
            Positioned(
              child: BlocBuilder<AddToCartBloc, AddToCartStates>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length+1,
                      itemBuilder: (context, index) {
                        if(index == 0){
                          return  Padding(
                            padding: index == list.length+1 ? EdgeInsets.only(top: 20.0,bottom: 50) : EdgeInsets.only(top: 20.0),
                            child: Text("Salad & Soups",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          );
                        } else if(index == list.length && state is AddToCartLoadedState && state.list.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: ItemTile(itemModel: list[index-1],),
                          );
                        } else {
                          return ItemTile(itemModel: list[index-1],);
                        }
                  }
                  );
                }
              ),
            ),
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: BlocBuilder<AddToCartBloc, AddToCartStates>(
                builder: (context, state) {
                  // if() {
                  return Visibility(
                    visible: state is AddToCartLoadedState && state.list.isNotEmpty,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart_outlined,color: Colors.grey,size: 24,),
                            const SizedBox(width: 5,),
                            Text(state is AddToCartLoadedState ? "${state.list.length} Items" : "",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, CheckoutScreen.routeName,arguments: state is AddToCartLoadedState ? state.list : []);
                                },
                                child: const Text("Place Order")
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  // }
                }
            ))
          ],
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  ItemTile({
    Key? key, required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;
  late ValueNotifier<int> count;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    count = ValueNotifier(itemModel.count ?? 0);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(bottom: 20),
      height: height / 6,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300,width: 2)),
        ),
      child: Row(
            children: [
              Container(
                width: width / 3,
                height: height / 7,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage(itemModel.image!))),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemModel.title!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Text(itemModel.desc!,
                    style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),
                    maxLines: 2,overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.energy_savings_leaf,color: Colors.green,),
                      const SizedBox(width: 5,),
                      Text("\$${itemModel.price}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      const Spacer(),
                      AddItemButton(count: count, itemModel: itemModel)
                    ],
                  ),
                ],
              ))
            ],
          ),
    );
  }
}


