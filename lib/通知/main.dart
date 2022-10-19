import 'package:firebase_messaging/firebase_messaging.dart'; // ライブラリのインポート

void main() {
  runApp(MyApp());
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

// 省略
class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      // tokenの中にFcmTokenが入ってる
      print("Push Messaging token: $token");
      // firestoreへtokenの更新を行う
      // 省略
    });
  }
}
