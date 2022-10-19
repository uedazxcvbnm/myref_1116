//popUpPage 登録画面で入力したものを最終確認する画面
// alertdialog https://www.kamo-it.org/blog/flutter-dialog/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './main.dart';
import './page1.dart';
import './page2.dart';
import './nextpage.dart';
import './main3_4.dart';
import './provider.dart';
/*import './page3.dart';
import './page4.dart';*/
import './database_myref.dart';
import './database_material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:stream_transform/stream_transform.dart';
import './main.dart';
import 'package:blobs/blobs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//final BottomNavigationBar navigationBar = navBarGlobalKey.currentWidget;

// popUPPage 登録された食品の最終確認画面
class popUpPage extends StatefulWidget {
  const popUpPage({Key? key}) : super(key: key);
  //final String title;
  @override
  State<popUpPage> createState() => _popUpState();
}

class _popUpState extends State<popUpPage> {
  //https://qiita.com/ysk-cpu/items/20f2095a7cb842bab4d9
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? selectedNotificationPayload;

  Future<void> main() async {
    // needed if you intend to initialize in the `main` function
    WidgetsFlutterBinding.ensureInitialized();

    await _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
    });

    runApp(MyApp());
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  @override
  Widget _buildTile(BuildContext context) {
    //return SwitchListTile(
    return Scaffold(
        appBar: AppBar(
            //title: Text(widget.title),
            ),
        body: Row(children: <Widget>[
          Text("10:00 AM"),
          Text(""),
          /*onTapped: (bool value) async {
              var t = "10:00 AM";
              final format = DateFormat.jm();
              TimeOfDay schedule = TimeOfDay.fromDateTime(format.parse(t));
              value
                  ? _cancelNotification(0)
                  : _zonedScheduleNotification(schedule, 0);
            }*/
        ]));
  }

  Future<void> _zonedScheduleNotification(TimeOfDay t, int i) async {
    // iは通知のID 同じ数字を使うと上書きされる
    tz.TZDateTime _nextInstanceOfTime() {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local, now.year, now.month, now.day, t.hour, t.minute);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'scheduled title',
        'scheduled body',
        _nextInstanceOfTime(),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _cancelNotification(int i) async {
    //IDを指定して通知をキャンセル
    await flutterLocalNotificationsPlugin.cancel(i);
  }
}
