import 'dart:async';
import 'package:flutter/material.dart';

class MoneyAddPage extends StatefulWidget {
  @override
  _MoneyAddPageState createState() => _MoneyAddPageState();
}

class _MoneyAddPageState extends State<MoneyAddPage> {
  String _item = '';
  String _value = '';
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('無駄遣い入力'),
      ),
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            Text(_item, style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 8),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 1),
                );

                if (selectedDate != null) {
                // do something
                }
              },
            ),

            // テキスト入力
            TextField(
              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String item) {
                // データが変更したことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _item = item;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.face),
                hintText: '品目を入力してください',
                labelText: '品目',
              ),
            ),
            TextField(
              onChanged: (value) async {
                setState(() {
                  _value = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.face),
                hintText: '金額を入力してください',
                labelText: '金額',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  //Navigator.of(context).pop(_item);
                  Navigator.of(context).pop([_item, _value]);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

