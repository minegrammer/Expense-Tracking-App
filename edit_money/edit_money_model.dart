
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:record_waste_money/domain/money.dart';

class EditMoneyModel extends ChangeNotifier {
  final Money money;
  EditMoneyModel(this.money) {
    itemController.text = money.item;
    valueController.text = money.value;
  }

  final itemController = TextEditingController();
  final valueController = TextEditingController();

  String? item;
  String? value;

  void setItem(String item) {
    this.item = item;
    notifyListeners();
  }

  void setValue(String value) {
    this.value = value;
    notifyListeners();
  }

  bool isUpdated() {
    return item != null || value != null;
  }

  Future update() async {
    this.item = itemController.text;
    this.value = valueController.text;

    // firestoreに追加
    await FirebaseFirestore.instance.collection('records').doc(money.id).update({
      'item': item,
      'value': value,
    });
  }
}