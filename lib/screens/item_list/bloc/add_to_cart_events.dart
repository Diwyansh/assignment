part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvents {}

class AddItem extends AddToCartEvents {
  final ItemModel itemModel;

  AddItem(this.itemModel);
}

class RemoveItem extends AddToCartEvents {
  final ItemModel itemModel;

  RemoveItem(this.itemModel);
}

class UpdateItem extends AddToCartEvents {
  final ItemModel itemModel;

  UpdateItem(this.itemModel);
}