//firabaseとAndroidの接続
//https://tokku-engineer.tech/create-pj-flutterfirebase-ios-android-initial/
//https://minpro.net/unhandled-exception-servicesbinding-defaultbinarymessenger-was-accessed-before-the-binding-was-initialized

/*クラス名
MyStatefulWidget　画面下部のバーを作るときに必要なクラス　画面を表示しているクラスではない
MyHomePage　食品の登録画面
*/
//StreamBuilderを使おうとしたけど、エラーが出たのでコメントしてます
import 'package:flutter/material.dart';
import './page1.dart';
import './page2.dart';
import './nextpage.dart';
import './recipe_recommend1.dart';
import './main3_4.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:stream_transform/stream_transform.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:blobs/blobs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riv;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './local_notifications.dart';

LocalNotifications localNotifications = new LocalNotifications();

final GlobalKey<NavigatorState> navBarGlobalKey = GlobalKey<NavigatorState>();

//BottomNavigationBar
Future<void> main() async {
  //Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const riv.ProviderScope(child: MyApp()),
  );
  localNotifications.Initialization();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'BottomNavBar Code Sample';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomNavBar Code Sample',
      home: MyStatefulWidget(),
      initialRoute: '/',
      routes: {
        //'/': (context) => MyHomePage(),
        //'/page2': (context) => NextPage(),
      },
    );
  }
}

//画面上部のバー　食材を種類ごとに分類する画面に移動するボタン
class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

//MyStatefulWidget　ボトムナビゲーションバーを作るときに必要なクラス（画面下部のバー）
class MyStatefulWidget extends StatefulWidget {
  //constが必要
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

//画面下部のバー　画面移動するボタン
//画面下部のバー　画面移動するボタン
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  var _childPageList = <Widget>[
    //食品の登録画面
    MyHomePage(),
    //食品を表示する画面
    NextPage(),
    //賞味期限が切れそうな食品で作った料理の紹介画面
    RecipePage(),
    //設定画面
    homePage4(),
  ];
  //画面移動するボタンの関数　画面下部のバー
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //画面下部のバー　https://zenn.dev/urasan/articles/5bb85a54fb23fb
  //https://qiita.com/taki4227/items/e3c7e640b7986a80b2f9

  //https://qiita.com/canisterism/items/d648da85c300a3751db0 に変更
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //2
      appBar: AppBar(
        //title: const Text('DEMO'),
        title: Text('賞味期限管理アプリ'),
        backgroundColor: Colors.green,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _childPageList,
      ),
      backgroundColor: Colors.green,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        //画面を移動するボタン
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            //Flutter3なのでここではlabelを使うべき
            label: 'ラベル1',
            //バーの色はここで設定する
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ラベル2',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'ラベル3',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ラベル4',
            backgroundColor: Colors.green,
          ),
        ],
        // 選択したときはオレンジ色にする
        //color: Colors.green,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        // タップできるように
        onTap: _onItemTapped,
      ),
    );
  }
}

//食品の登録画面（追加画面）MyHomePage　ボトムナビゲーションバーの１つ目のページ（食品を登録する画面）
class HomeWidget extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

//https://zenn.dev/ryouhei_furugen/articles/ebcd36964b0182
class Material {
  // ドキュメントを扱うDocumentSnapshotを引数にしたコンストラクタを作る
  //聞くしかない
  Material(DocumentSnapshot doc) {
    //　ドキュメントの持っているフィールド'title'をこのBookのフィールドtitleに代入
    id = doc['id'];
    //count = doc['count'];
    name = doc['name'];
    kana = doc['kana'];
    category = doc['category'];
    exday = doc['exday'];
    image = doc['image'];
  }

  // Bookで扱うフィールドを定義しておく。
  //ここに?をつけたら動いた
  //型をvarにした
  //https://computer.sarujincanon.com/2022/01/03/non-nullable-instance_error/]
  //String? id;
  //String? id, date;
  var id, name, kana, category, exday, image;
}

class MainModelMaterial extends ChangeNotifier {
  // ListView.builderで使うためのBookのList booksを用意しておく。
  List<Material> material = [];
  Future<void> fetchmaterial() async {
    // Firestoreからコレクション'books'(QuerySnapshot)を取得してdocsに代入。
    final docs = await FirebaseFirestore.instance.collection('material').get();
    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // map(): Listの各要素をBookに変換
    // toList(): Map()から返ってきたIterable→Listに変換する。
    final material = docs.docs.map((doc) => Material(doc)).toList();
    this.material = material;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePage();
}

//https://flutter.keicode.com/basics/tabbarview.php
class _MyHomePage extends State<MyHomePage> {
//class _MyHomePage extends ConsumerWidget {
  //食品を種類ごとに分類して表示する画面に、移動するボタン
  final List<TabInfo> _tabs = [
    TabInfo("野菜・果物", Page1()),
    TabInfo("肉・魚", Page2()),
    //TabInfo("インスタント食品", Page3()),
    //TabInfo("頻繁に買う食品", Page4()),
  ];

  //var _selectedvalue = 1;

  //仮
  var documentID = 0;

  // タイトルインプットテキストコントローラー
  TextEditingController titleTextEditingController = TextEditingController();
  // 内容インプットテキストコントローラー
  TextEditingController contentsTextEditingController = TextEditingController();

  // ローカル通知の初期化
  LocalNotifications localNotifications = new LocalNotifications();

  // 選択されている日付
  //DateTime? selectDateTime = null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<MainModelMaterial>(
          create: (_) => MainModelMaterial()..fetchmaterial(),
          child: Scaffold(
            //children: <Widget>[
            //title: 'Grid List',
            //children:<Widget>[
            //return Scaffold(
            appBar: AppBar(
              //title: Text('賞味期限管理アプリ'),
              backgroundColor: Colors.green,
              bottom: PreferredSize(
                child: TabBar(
                  isScrollable: true,
                  tabs: _tabs.map((TabInfo tab) {
                    return Tab(text: tab.label);
                  }).toList(),
                ),
                preferredSize: Size.fromHeight(30.0),
              ),
            ),
            body: Consumer<MainModelMaterial>(
              builder: (context, model, child) {
                final material = model.material;
                /*return Center(
                                child: StreamBuilder(
                                  stream: streamName(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // 非同期処理未完了 = 通信中
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }*/
                //食品の登録画面
                //https://flutter.ctrnost.com/layout/body/grid/
                return GridView.builder(
                  //crossAxisCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //カラム数
                  ),
                  itemCount: material.length, //要素数
                  itemBuilder: (context, index) {
                    //return Container(
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Text('ID' + material[index].id.toString()),
                          Text(material[index].name.toString()),
                          Text('保存期間' + material[index].exday.toString() + '日'),
                          //Container(
                          GestureDetector(
                            child: InkWell(
                              //SpringButtonType.WithOpacity,
                              //タップエフェクト　色がピンクにならないけど、色は透明の方がいい
                              //https://www.choge-blog.com/programming/flutterinkwelltapeffectcolor/
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                /*await FirebaseFirestore.instance
                                          .collection('refri')
                                          .doc('id_abc')
                                          .set({
                                        'id': 4,
                                        'date': '2022/10/7',
                                        'name': 'オクラ',
                                      });*/
                                //今日の日付
                                var now = DateTime.now();
                                //日付の表示形式
                                var _now = DateFormat('yyyy-MM-dd').format(now);
                                //stringからDateTimeに変換
                                var _nowDate = DateTime.parse(_now);

                                //一時的なテスト 10日前
                                //https://qiita.com/seiboy/items/7b632103088c5ed65082
                                //_nowDate = _nowDate.add(Duration(days: 1) * -1);
                                //_nowDate =_nowDate.add(Duration(days: 1) * 1);
                                //_nowDate=_nowDate.add(Duration(days:2)*1);

                                //firebaseで使用する場合、var sql3の定義が悪かった
                                //var sql3 = material[index].id;
                                int sql4 = material[index].exday;

                                //賞味期限の計算　賞味期限＝今日の日付+materialテーブルのexdayカラム
                                var _time = _nowDate.add(Duration(days: sql4));
                                var _nowtime =
                                    DateFormat('yyyy-MM-dd').format(_time);

                                documentID++;

                                bool isComppleted = await localNotifications
                                    .SetLocalNotification(
                                        titleTextEditingController.text,
                                        contentsTextEditingController.text,
                                        DateTime.parse(_nowtime));

                                await FirebaseFirestore.instance
                                    .collection('refri')
                                    .doc(documentID.toString())
                                    .set({
                                  //'id': material[index].id.toString(),
                                  'id': documentID,
                                  'date': _nowtime.toString(),
                                  //'name': material[index].name.toString(),
                                  'name': material[index].name,
                                });
                              },

                              child: Container(
                                width: 90,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        material[index].image.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
