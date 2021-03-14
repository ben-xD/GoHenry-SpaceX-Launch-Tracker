import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/service/launch.dart';
import 'package:space_time/ui/screen/upcoming_launches.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(172, 85, 138, 1),
    ));

    final service = useProvider(launchServiceProvider);

    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
            primaryColor: Color.fromRGBO(172, 85, 138, 1),
            accentColor: Color.fromRGBO(83, 201, 193, 1),
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72),
              headline4: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontSize: 20, color: Colors.white),
              bodyText2: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
            )),
        home: FutureBuilder<List<LaunchMission>>(
            future: service.getUpcomingLaunches(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                    body: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Oh lord.",
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          "This app is completely useless when the data from the interwebs doesn't come in.",
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ));
              }
              return UpcomingLaunches(snapshot.data, snapshot.connectionState);
            }));
  }
}
