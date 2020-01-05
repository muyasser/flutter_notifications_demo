import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

main(List<String> args) {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> onSelectNotification(String payload) {
    print('Payload is: $payload');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text('$payload'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Show Notification',
            style: Theme.of(context).textTheme.headline,
          ),
          onPressed: showNotification,
        ),
      ),
    );
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        importance: Importance.Max);
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(
        0, 'New products are available', 'Flutter notification', platform,
        payload: 'Hello, Flutter!');
  }
}
