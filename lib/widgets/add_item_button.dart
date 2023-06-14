
import 'package:assignment/constants/data_constants.dart';
import 'package:assignment/screens/item_list/bloc/add_to_cart_bloc.dart';
import 'package:assignment/screens/item_list/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    Key? key,
    required this.count,
    required this.itemModel,
  }) : super(key: key);

  final ValueNotifier<int> count;
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: count,
        builder: (context, value, widget) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12)
            ),
            // width: 80,
            child: value == 0 ? InkWell(
              onTap: (){
                count.value++;
                itemModel.count = count.value;
                context.read<AddToCartBloc>().add(AddItem(itemModel));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                child: Text("Add",style: TextStyle(fontSize: 16,color: Colors.green)),
              ),
            ) : Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(onPressed: () {
                    count.value--;
                    itemModel.count = count.value;
                    if(count.value > 0) {
                      context.read<AddToCartBloc>().add(UpdateItem(itemModel));
                    } else {
                      context.read<AddToCartBloc>().add(RemoveItem(itemModel));
                    }
                  },padding: EdgeInsets.zero,splashRadius: 15,
                      icon: const Icon(Icons.remove,size: 16,color: Colors.green,)),
                ),
                Text("${count.value}",style: const TextStyle(fontSize: 16,color: Colors.green)),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(onPressed: () {
                    count.value++;
                    itemModel.count = count.value;
                    context.read<AddToCartBloc>().add(UpdateItem(itemModel));
                  },
                      padding: EdgeInsets.zero,splashRadius: 15,
                      icon: const Icon(Icons.add,size: 16,color: Colors.green,)),
                )
              ],
            ),
          );
        }
    );
  }
}