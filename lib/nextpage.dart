//NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './main.dart';
import './page1.dart';
import './page2.dart';
import './main3_4.dart';
import './expired.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:stream_transform/stream_transform.dart';
import 'package:blobs/blobs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// NextPage ボトムナビゲーションバーの２つ目のページ（冷蔵庫の中にある食材一覧の画面）
class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);
  //final String title;
  @override
  State<NextPage> createState() => _NextPageState();
}

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
    //final docs = await FirebaseFirestore.instance.collection('refri').get();
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
  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    return Scaffold(
      body: Column(
        children: [
          /*Container(
            padding: EdgeInsets.all(8),
            child: Text('ログイン情報：${user.email}'),
          ),*/
          Expanded(
            // FutureBuilder
            // 非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              // 投稿メッセージ一覧を取得（非同期処理）
              // 投稿日時でソート
              stream:
                  FirebaseFirestore.instance.collection('refri').snapshots(),
              builder: (context, snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  // 取得した投稿メッセージ一覧を元にリスト表示
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                            //children: <Widget>[
                            leading: Text(document['id'].toString()),
                            title: Text(document['name'].toString()),
                            subtitle: Text(document['date'].toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                // 投稿メッセージのドキュメントを削除
                                await FirebaseFirestore.instance
                                    .collection('refri')
                                    .doc(document.id.toString())
                                    .delete();
                              },
                            )
                            //],
                            ),
                      );
                    }).toList(),
                  );
                }
                // データが読込中の場合
                return Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
