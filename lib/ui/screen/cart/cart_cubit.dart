import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nws_hieuvm_ecommerce_flutter/database/firebase_firestore_service.dart';
import 'package:nws_hieuvm_ecommerce_flutter/model/entities/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());
  final FireStoreService fireStoreService = FireStoreService();

  void getListCart(int id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final responseListCart = await fireStoreService.getCart(id);
      emit(state.copyWith(
        listCart: responseListCart,
      ));
    } catch (e) {
      print('err $e');
    }
  }

  void increment(int index) {
    var listProduct = state.listCart;
    listProduct?[index].quantity =
    listProduct[index].quantity == null ? 1 : (listProduct[index].quantity! +
        1);
    emit(state.copyWith(
        listCart: listProduct,
    ));
    ///TODO HANDLE UPDATE TO FIREBASE
  }
  void decrement(int index) {
    var listProduct = state.listCart;
    listProduct?[index].quantity =
    listProduct[index].quantity == null ? 0 : (listProduct[index].quantity! -
        1);
    emit(state.copyWith(
        listCart: listProduct,
    ));
    ///TODO HANDLE UPDATE TO FIREBASE
  }

}
