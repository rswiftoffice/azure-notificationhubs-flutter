import 'package:flutter/material.dart';
import 'package:azure_notificationhubs_flutter/azure_notificationhubs_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AzureNotificationhubsFlutter _anh;

  @override
  void initState() {
    super.initState();
    _anh.configure(
      onLaunch: (Map<String, dynamic> notification) async {
        print('onLaunch: $notification');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
            title: Text(notification['data']['title']),
            subtitle: Text(notification['data']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> notification) async {
        print('onResume: $notification');
      },
      onMessage: (Map<String, dynamic> notification) async {
        print('onMessage: $notification');
      },
      onToken: (String token) async {
        print('onToken: $token');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Azure notification hubs example app'),
        ),
        body: Center(
          child: Text('https://github.com/rswiftoffice/azure-notificationhubs-flutter/ & https://github.com/19hours'),
        ),
      ),
    );
  }
}
