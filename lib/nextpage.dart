//NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './main.dart';
import './page1.dart';
import './page2.dart';
import './main3_4.dart';
//import './popup_check.dart';
import './expired.dart';
/*import './page3.dart';
import './page4.dart';*/
//import './database_myref.dart';
//import './database_myref2.dart';
//import './database_material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:stream_transform/stream_transform.dart';
import 'package:blobs/blobs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);
  //final String title;
  @override
  State<NextPage> createState() => _NextPageState();
}

/*class _NextPageState extends State<NextPage> {
  var _selectedValue = '機能１';
  var _usStates = ["機能１", "機能２", "機能３"];

  //メモリスト
  List<Refri> _memolist = [];
  Stream<int> initializeDemo() async* {
    _memolist = await Refri.getMemos();
  }

  List<Material_db> _memolist2 = [];
  Stream<int> initializeDemo2() async* {
    _memolist2 = await Material_db.getMaterial();
  }

  List<Refri2> _memolist3 = [];
  Stream<int> initializeDemo3() async* {
    _memolist3 = await Refri2.getMemos2();
  }

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

  var _isAscending = true;
  var _currentSortColumn = 0;

  //引っ張って更新https://note.com/hatchoutschool/n/n67eb3d9106f1
  Future _loadData() async {
    //Future.delay()を使用して擬似的に非同期処理を表現
    await Future.delayed(Duration(seconds: 2));

    //print('Loaded New Data');

    setState(() {
      //新しいデータを挿入して表示
      _memolist3;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('賞味期限管理アプリ'),
        backgroundColor: Colors.green,
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Expired_food())));
            },
          ),
        ],
      ),
      body: SizedBox(
        //children:[
        //Expanded(
        //child: DataTable(
        child: RefreshIndicator(
          onRefresh: () async {
            //print('Loading New Data');
            await _loadData();
          },
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
                      //children: <Widget>[
                      children: <Widget>[
                        //if () ...[
                        //ifの順番を入れ替えたら動いた　count!=0が135行目、賞味期限の判定は136行目
                        //count!=0は動く
                        //https://zenn.dev/taji/articles/d1d94b5efbed35
                        if (_memolist3[index].count != 0) ...[
                          if (DateTime.parse(_now).isBefore(
                              DateTime.parse(_memolist3[index].date))) ...[
                            //refriテーブルのid
                            Text(
                              'ID${_memolist3[index].id.toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //refriテーブルのdate
                            Text('${_memolist3[index].date}'),
                            //refriテーブルのcount
                            Text(
                                'count  ${_memolist3[index].count.toString()}'),
                            //refriテーブルのname
                            //ここだけ_memolist2（materialテーブル）を使う
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
                                  var update_refri3 = Refri(
                                      id: _memolist3[index].id,
                                      count: _counter,
                                      date: _memolist3[index].date,
                                      name: _memolist[index].name);
                                  await Refri.updateMemo(update_refri3);
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
        //),
        //],
      ),
    );
  }
}*/
//https://zenn.dev/ryouhei_furugen/articles/ebcd36964b0182
class Refri {
  // ドキュメントを扱うDocumentSnapshotを引数にしたコンストラクタを作る
  //聞くしかない
  Refri(DocumentSnapshot doc) {
    //　ドキュメントの持っているフィールド'title'をこのBookのフィールドtitleに代入
    id = doc['id'];
    //count = doc['count'];
    date = doc['date'];
    name = doc['name'];
  }

  // Bookで扱うフィールドを定義しておく。
  //ここに?をつけたら動いた
  //型をvarにした
  //https://computer.sarujincanon.com/2022/01/03/non-nullable-instance_error/]
  //String? id;
  //String? id, date;
  var id, date, name;
}

class MainModel extends ChangeNotifier {
  // ListView.builderで使うためのBookのList booksを用意しておく。
  List<Refri> refri = [];
  Future<void> fetchrefri() async {
    // Firestoreからコレクション'books'(QuerySnapshot)を取得してdocsに代入。
    final docs = await FirebaseFirestore.instance.collection('refri').get();

    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // map(): Listの各要素をBookに変換
    // toList(): Map()から返ってきたIterable→Listに変換する。
    final refri = docs.docs.map((doc) => Refri(doc)).toList();
    this.refri = refri;
    notifyListeners();
  }
}

class _NextPageState extends State<NextPage> {
  /*var _selectedValue = '機能１';
  var _usStates = ["機能１", "機能２", "機能３"];

  //メモリスト
  List<Refri> _memolist = [];
  Stream<int> initializeDemo() async* {
    _memolist = await Refri.getMemos();
  }

  List<Material_db> _memolist2 = [];
  Stream<int> initializeDemo2() async* {
    _memolist2 = await Material_db.getMaterial();
  }

  List<Refri2> _memolist3 = [];
  Stream<int> initializeDemo3() async* {
    _memolist3 = await Refri2.getMemos2();
  }

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

  var _isAscending = true;
  var _currentSortColumn = 0;

  //引っ張って更新https://note.com/hatchoutschool/n/n67eb3d9106f1
  Future _loadData() async {
    //Future.delay()を使用して擬似的に非同期処理を表現
    await Future.delayed(Duration(seconds: 2));

    //print('Loaded New Data');

    setState(() {
      //新しいデータを挿入して表示
      _memolist3;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..fetchrefri(),
        child: Scaffold(
          body: Consumer<MainModel>(
            //child: Column(
            //children: [
            /*Container(
              padding: EdgeInsets.all(8),
              //child: Text('ログイン情報：${user.email}'),
            ),*/
            //Expanded(
            // FutureBuilder
            // 非同期処理の結果を元にWidgetを作れる
            //child: FutureBuilder<QuerySnapshot>(
            // 投稿メッセージ一覧を取得（非同期処理）
            // 投稿日時でソート
            /*future: FirebaseFirestore.instance
                      .collection('refri')
                      //.where('refri')
                      //.doc('refri')
                      .orderBy('date')
                      .get(),*/
            builder: (context, model, child) {
              // データが取得できた場合
              //if (snapshot.hasData) {
              /*final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;*/
              // 取得した投稿メッセージ一覧を元にリスト表示
              final refri = model.refri;
              //try {
              return ListView.builder(
                itemCount: refri.length,
                //itemCount: _memolist2.length,
                itemBuilder: (context, index) {
                  //return ListTile(
                  return Card(
                    child: Column(
                      children: <Widget>[
                        //children: <Widget>[
                        //if () ...[
                        //ifの順番を入れ替えたら動いた　count!=0が135行目、賞味期限の判定は136行目
                        //count!=0は動く
                        //https://zenn.dev/taji/articles/d1d94b5efbed35
                        if (refri[index].date != null) ...[
                          /*if (DateTime.parse(_now).isBefore(
                                          DateTime.parse(
                                              _memolist3[index].date))) ...[*/
                          //refriテーブルのid
                          //children: <Widget>[
                          //title: Text(refri[index].id.toString()),
                          Text('id' + refri[index].id.toString()),
                          //subtitle: Text(refri[index].date.toString()),
                          Text(refri[index].date.toString()),
                          Text(refri[index].name.toString()),
                          ElevatedButton(
                            child: Text('ドキュメント削除'),
                            onPressed: () async {
                              // ドキュメント削除
                              await FirebaseFirestore.instance
                                  .collection('refri')
                                  .doc('id_abc')
                                  .delete();
                            },
                          ),
                          //],
                          /*Text(
                                  'ID${_memolist3[index].id.toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),*/
                          //Text(document['id']),
                          //refriテーブルのdate
                          //Text('${_memolist3[index].date}'),
                          //Text(document['count']),
                          //refriテーブルのcount
                          //Text(
                          //'count  ${_memolist3[index].count.toString()}'),
                          //Text(document['']),
                          //refriテーブルのname
                          //ここだけ_memolist2（materialテーブル）を使う
                          //Text(document['id']),
                          //Text('name${_memolist[index].name}'),
                          //削除ボタン　これを押すとエラーになるので、後で変更する予定
                          /*SizedBox(
                                  width: 76,
                                  height: 25,
                                  //RaisedButtonは古い　ElavatedButtonが推奨される
                                  child: ElevatedButton(
                                    child: Text('削除'),
                                    onPressed: () async {
                                      var _counter = _memolist3[index].count - 1;
                                      var update_refri3 = Refri(
                                          id: _memolist3[index].id,
                                          count: _counter,
                                          date: _memolist3[index].date,
                                          name: _memolist[index].name);
                                      await Refri.updateMemo(update_refri3);
                                      final List<Refri2> memos =
                                          await Refri2.getMemos2();
                                      setState(() {
                                        _memolist3 = memos;
                                      });
                                    },
                                  ),
                                ),*/
                        ],
                        //],
                      ],
                    ),
                  );
                  //);
                },
              );
            },
            //),
            //),
            //],
            //),
          ),
        ),
      ),
    );
  }
}
