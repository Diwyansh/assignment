import 'package:assignment/constants/data_constants.dart';
import 'package:assignment/screens/item_list/model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_to_cart_events.dart';
part 'add_to_cart_states.dart';

class AddToCartBloc extends Bloc<AddToCartEvents,AddToCartStates> {

  List<ItemModel> list = [];

  AddToCartBloc() : super(AddToCartInitialState()) {

    on<AddItem>((event, emit) {
      emit(AddToCartLoadingState());
      for (Map<String,dynamic> element in DataConstants.listData) {
        if(element["id"] == event.itemModel.id) {
          element["count"] = event.itemModel.count;
          print( element["count"]);
        }
      }
      list.add(event.itemModel);
      emit(AddToCartLoadedState(list));
    });

    on<RemoveItem>((event, emit) {
      emit(AddToCartLoadingState());
      for (Map<String,dynamic> element in DataConstants.listData) {
        if(element["id"] == event.itemModel.id) {
            element["count"] = event.itemModel.count;
        }
      }
      list.remove(event.itemModel);
      emit(AddToCartLoadedState(list));
    });

    on<UpdateItem>((event, emit) {
      emit(AddToCartLoadingState());
        int index = list.indexOf(event.itemModel);
        list[index] = event.itemModel;
        emit(AddToCartLoadedState(list));
    });

  }

}