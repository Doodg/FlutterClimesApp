import 'package:climes_app/network/retrofit_client.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'ui/home_page.dart';
import 'l10n/s.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((onData) =>
      {print("${onData.level.name} : ${onData.time} : ${onData.message}")});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => RetrofitClient.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [S.delegate],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
