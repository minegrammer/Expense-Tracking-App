// リスト一覧画面用Widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:record_waste_money/add_money/add_money_page.dart';
import 'package:record_waste_money/money_list/money_list_model.dart';
import 'package:record_waste_money/domain/money.dart';
import 'package:record_waste_money/edit_money/edit_money_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:record_waste_money/exe.dart';

class MoneyListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoneyListModel>(
      create: (_) => MoneyListModel()..fetchMoneyList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('無駄遣い一覧'),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      // 遷移先の画面としてリスト追加画面を指定
                      return Exe();
                    }),
                  );
                },
                icon: Icon(Icons.person_add)
            ),
          ],
        ),
        body: Center(
          child: Consumer<MoneyListModel>(builder: (context, model, child) {
            final List<Money>? moneys = model.moneys;

            if (moneys == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = moneys
                .map(
                  (money) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      title: Text(money.item),
                      subtitle: Text(money.value),
                    ),
                    secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: '編集',
                      color: Colors.black45,
                      icon: Icons.edit,
                      onTap: () async {
                      // 画面遷移
                        final String? title = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMoneyPage(money),
                          ),
                        );
                        if (title != null) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('$titleを編集しました'),
                          );
                          ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                        }
                        model.fetchMoneyList();
                      },
                    ),
                    IconSlideAction(
                      caption: '削除',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        // 削除しますか？って聞いて、はいだったら削除
                        await showConfirmDialog(context, money, model);
                      },
                  ) ,
                ],
              ),
            ).toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<MoneyListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMoneyPage(),
                  fullscreenDialog: false,
                ),
              );
              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('記録を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              model.fetchMoneyList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
  Future showConfirmDialog(
      BuildContext context,
      Money money,
      MoneyListModel model,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${money.item}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                // modelで削除
                await model.delete(money);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${money.item}を削除しました'),
                );
                model.fetchMoneyList();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
