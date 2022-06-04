

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_waste_money/domain/money.dart';
import 'package:record_waste_money/edit_money/edit_money_model.dart';

class EditMoneyPage extends StatelessWidget {
  final Money money;
  EditMoneyPage(this.money);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditMoneyModel>(
      create: (_) => EditMoneyModel(money),
      child: Scaffold(
        appBar: AppBar(
          title: Text('記録を編集'),
        ),
        body: Center(
          child: Consumer<EditMoneyModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.itemController,
                    decoration: InputDecoration(
                      hintText: '品目',
                    ),
                    onChanged: (text) {
                      model.setItem(text);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: model.valueController,
                    decoration: InputDecoration(
                      hintText: '値段',
                    ),
                    onChanged: (text) {
                      model.setValue(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                      // 追加の処理
                      try {
                        await model.update();
                        Navigator.of(context).pop(model.item);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    }
                        : null,
                    child: Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}