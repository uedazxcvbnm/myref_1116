//NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './main.dart';
import './page1.dart';
import './page2.dart';
import './main3_4.dart';
//import './popup_check.dart';
/*import './page3.dart';
import './page4.dart';*/
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:stream_transform/stream_transform.dart';
import './main.dart';
import 'package:blobs/blobs.dart';

import 'package:flutter/cupertino.dart';

/*
// NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
class Expired_food extends StatefulWidget {
  const Expired_food({Key? key}) : super(key: key);
  //final String title;
  @override
  State<Expired_food> createState() => Expired_foodState();
}

class Expired_foodState extends State<Expired_food> {
  var _selectedValue = '機能１';
  var _usStates = ["機能１", "機能２", "機能３"];

  //メモリスト
  /*List<Refri_1> _memolist = [];
  Stream<int> initializeDemo() async* {
    _memolist = await Refri_1.getMemos();
  }

  List<Material_db> _memolist2 = [];
  Stream<int> initializeDemo2() async* {
    _memolist2 = await Material_db.getMaterial();
  }

  List<Refri2> _memolist3 = [];
  Stream<int> initializeDemo3() async* {
    _memolist3 = await Refri2.getMemos2();
  }*/

  //複数のテーブルを同時に取得するために必要な関数
  //https://qiita.com/ninoko1995/items/fe7115d8030a7a4cce0d
  Stream<Map<String, dynamic>> streamName2() {
    return initializeDemo()
        .combineLatestAll([initializeDemo2(), initializeDemo3()]).map((data) {
      return {
        "initializeDemo": data[0],
        "initializeDemo2": data[1],
        "initializeDemo3()": data[2],
      };
    });
  }

  //id番号
  var _selectedvalue_id;

  //非同期関数定義
  int apple_counter = 0;
  var _now = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //ウィジェットの表示/非表示で使うもの
  DateTime _now2 = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('賞味期限管理アプリ'),
        backgroundColor: Colors.green,
        //automaticallyImplyLeading: false,
        /*actions: [
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => popUpPage())));
            },
          ),
        ],*/
      ),
      body: Center(
        child: StreamBuilder(
          stream: streamName2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 非同期処理未完了 = 通信中
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //表示画面
            return ListView.builder(
              itemCount: _memolist3.length,
              //itemCount: _memolist2.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      if (_memolist3[index].count != 0) ...[
                        if (DateTime.parse(_now).isAfter(
                            DateTime.parse(_memolist3[index].date))) ...[
                          //if (_memolist3[index].count != 0)
                          //refriテーブルのid
                          Text(
                            'ID${_memolist3[index].id.toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          //refriテーブルのdate
                          Text('${_memolist3[index].date}'),
                          //refriテーブルのcount
                          Text('count  ${_memolist3[index].count.toString()}'),
                          //refriテーブルのname
                          Text('name${_memolist[index].name}'),
                          //削除ボタン　これを押すとエラーになるので、後で変更する予定
                          SizedBox(
                            width: 76,
                            height: 25,
                            //RaisedButtonは古い　ElavatedButtonが推奨される
                            child: ElevatedButton(
                              child: Text('削除'),
                              onPressed: () async {
                                var _counter = _memolist3[index].count - 1;
                                var update_refri3 = Refri_1(
                                    id: _memolist3[index].id,
                                    count: _counter,
                                    date: _memolist3[index].date,
                                    name: _memolist[index].name);
                                await Refri_1.updateMemo(update_refri3);
                                final List<Refri2> memos =
                                    await Refri2.getMemos2();
                                setState(() {
                                  _memolist3 = memos;
                                });
                              },
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}*/
