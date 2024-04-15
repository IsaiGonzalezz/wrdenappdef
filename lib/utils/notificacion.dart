import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseFirestore.instance
        .collection('sensor')
        .doc('fuego')
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if ((documentSnapshot.data() as Map<String, dynamic>)['unique_id'] ==
            1) {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails('fire_alerts', 'Alertas de fuego',
                  importance: Importance.max,
                  priority: Priority.high,
                  showWhen: false);
          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
          flutterLocalNotificationsPlugin.show(0, 'Notificación',
              'El valor de fuego es 1', platformChannelSpecifics,
              payload: 'item x');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Esperando notificaciones...'),
        ),
      ),
    );
  }
}
