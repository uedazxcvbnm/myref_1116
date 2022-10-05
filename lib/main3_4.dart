import 'package:flutter/material.dart';
import './nextpage.dart';
import './main.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//画面下部のバーの左から3つめのボタン　何も作っていない
class homePage3 extends StatefulWidget {
  //static const routeName = '/next';
  const homePage3({Key? key}) : super(key: key);
  //final String title;
  @override
  State<homePage3> createState() => _homePage3();
}

class _homePage3 extends State<homePage3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // デフォルト表示
            Text('Default'),
          ],
        ),
      ),
    );
  }
}

//画面下部のバーの左から4つめのボタン　何も作っていない
class homePage4 extends StatefulWidget {
  //static const routeName = '/next';

  const homePage4({Key? key}) : super(key: key);
  //final String title;
  @override
  State<homePage4> createState() => _homePage4();
}

//https://studio-cross.club/program_description/1545/#Github%E3%81%AB%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%82%92%E3%82%A2%E3%83%83%E3%83%97%E3%83%AD%E3%83%BC%E3%83%89%E3%81%97%E3%81%A6%E3%81%BE%E3%81%99%EF%BC%81
class _homePage4 extends State<homePage4> {
  DateTime? selectDateTime = null;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setSheetState) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //通知画面
                //Containerが無かったので、childに赤線が入っていた
                Container(
                  child: OutlinedButton(
                    child: Text(
                      "通知日付設定",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    onPressed: () async {
                      await DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          locale: LocaleType.jp,
                          currentTime: DateTime.now(),
                          onChanged: (time) {}, onConfirm: (time) {
                        setSheetState(() {
                          selectDateTime = time;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
