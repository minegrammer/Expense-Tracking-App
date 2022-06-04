import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddMoneyModel extends ChangeNotifier{
  String? item;
  String? value;

  Future addMoney() async {
    if (item == null || item == ""){
      throw '商品の名前が入力されていません';
    }
    if (value == null || value!.isEmpty){
      throw '商品の値段が入力されていません';
    }
    //firestoreに追加
    await FirebaseFirestore.instance.collection('records').add({
      'item': item,
      'value': value,
    });
  }
}