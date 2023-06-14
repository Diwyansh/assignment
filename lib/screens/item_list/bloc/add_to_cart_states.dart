part of 'add_to_cart_bloc.dart';

abstract class AddToCartStates extends Equatable {}

class AddToCartInitialState extends AddToCartStates {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCartLoadingState extends AddToCartStates {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCartLoadedState extends AddToCartStates {

  final List<ItemModel> list;

  AddToCartLoadedState(this.list);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
