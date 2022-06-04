
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:record_waste_money/domain/money.dart';

class MoneyListModel extends ChangeNotifier {
  final _userCollection =
  FirebaseFirestore.instance.collection('records');

  List<Money>? moneys;

  void fetchMoneyList() async {
    final QuerySnapshot snapshot = await _userCollection.get();

    final List<Money>moneys = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String item = data['item'];
      final String value = data['value'];
      return Money(id, item, value);
    }).toList();

    this.moneys = moneys;
    notifyListeners();
  }

  Future delete(Money money) {
    return FirebaseFirestore.instance.collection('records').doc(money.id).delete();
  }
}