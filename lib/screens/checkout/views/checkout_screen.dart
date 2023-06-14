import 'package:assignment/screens/item_list/bloc/add_to_cart_bloc.dart';
import 'package:assignment/screens/item_list/model/item_model.dart';
import 'package:assignment/widgets/add_item_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.itemsList}) : super(key: key);

  static String routeName = "/checkout";

  final List<ItemModel> itemsList;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Screen"),
      ),
      body: BlocBuilder<AddToCartBloc, AddToCartStates>(
        builder: (context, state) {
          if(state is AddToCartLoadedState) {
            return state.list.isEmpty ? Center(child: Text("Cart is empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),) : Stack(
              children: [
                Positioned(
                  top: 0,
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.list.length,
                        itemBuilder: (context, index) => index == state.list.length-1 ? Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: CheckoutListItem(itemModel: state.list[index]),
                        ) :  CheckoutListItem(itemModel: state.list[index]))
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
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Text(state is AddToCartLoadedState ? "Total : \$${getTotalFromItemList(state.list)}" : "",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    const Spacer(),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
                                        ),
                                        onPressed: (){
                                          Navigator.pushNamed(context, CheckoutScreen.routeName,arguments: state is AddToCartLoadedState ? state.list : []);
                                        },
                                        child: const Text("Checkout")
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
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}

class CheckoutListItem extends StatelessWidget {
   CheckoutListItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  late ValueNotifier<int> count;
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    count = ValueNotifier(itemModel.count!);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(itemModel.title!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),maxLines: 1,overflow: TextOverflow.ellipsis,)),
              AddItemButton(count: count, itemModel: itemModel)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(itemModel.desc!,style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),)),
              Expanded(child: Text("\$${itemModel.price}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,height: 2.25),textDirection: TextDirection.rtl,)),
            ],
          ),
        ],
      ),
    );
  }
}


double getTotalFromItemList(List<ItemModel> itemList) {

  double total = 0.0;

  for(final item in itemList) {
    double itemTotal = item.price! * item.count!;
    total += itemTotal;
  }

  return total;
}