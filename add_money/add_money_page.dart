// リスト一覧画面用Widget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_money_model.dart';

class AddMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMoneyModel>(
      create: (_) => AddMoneyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('記録追加'),
        ),
        body: Center(
          child: Consumer<AddMoneyModel>(builder: (context, model, child) {
            return Column(
              children:[
                 TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.face),
                    hintText: '品目を入力してください',
                    labelText: '品目',
                  ),
                   onChanged: (text) {
                    model.item = text;
                    },
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.face),
                    hintText: '金額を入力してください',
                    labelText: '金額',
                  ),
                  onChanged: (text) {
                    model.value = text;
                  },
                ),
                ElevatedButton(
                  onPressed: () async{
                    try {
                      await model.addMoney();
                      Navigator.of(context).pop(true);
                    } catch(e){
                      final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child:Text('追加する'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
