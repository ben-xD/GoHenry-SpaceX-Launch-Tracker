import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/service/launch.dart';
import 'package:space_time/ui/screen/launch_tabs.dart';
import 'package:space_time/ui/widget/launch_cell.dart';

import 'launch_countdown.dart';

class UpcomingLaunches extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpcomingLaunchesState();
}

class _UpcomingLaunchesState extends State<UpcomingLaunches> {
  LaunchMission? _selectedMission;

  void didSelectLaunchMission(LaunchMission mission) {
    setState(() {
      _selectedMission = mission;
    });
  }

  Widget getLaunchList(List<LaunchMission> missions) {
    return Navigator(
      pages: [
        MaterialPage(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                // TODO add count of saves badge to this
                IconButton(icon: Icon(Icons.star), onPressed: (){})
              ],
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromRGBO(172, 85, 138, 1), Color.fromRGBO(64, 22, 86, 1)])
                ),
              ),
              toolbarHeight: 100,
              title: Text("Upcoming Launches", style: TextStyle(fontSize: 24),),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 56, 42, 56),
                    Color.fromARGB(255, 38, 32, 48)
                  ])),
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.only(top: 16),
                  children: missions
                      .map((e) => LaunchCell(e, didSelectLaunchMission))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        if (_selectedMission != null)
          MaterialPage(child: LaunchTabs(_selectedMission!))
      ],
      onPopPage: (route, result) {
        return route.didPop(result);
      },
      // body: ListView.builder(
      //   itemCount: launchMissions == null ? 1 : _launchMissions.length + 1,
      //   itemBuilder: (BuildContext context, int index) {
      //     if (index == 0) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(children: [
      //           Text("Mission",
      //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //           ), // TODO wrap text if too big
      //           Spacer(),
      //           Text("Date (UTC)", style: TextStyle(fontWeight: FontWeight.bold),), // TODO wrap text if too big
      //         ],),
      //       );
      //     }
      //     return LaunchCell(_launchMissions[index - 1]);
      //   },
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO show loading (first animation, then try skeleton)
    return StreamBuilder(builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text("We weren't able to get data.");
      } else if (snapshot.hasData) {
        return getLaunchList(snapshot.data as List<LaunchMission>);
      } else {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          default:
            return Container(child: Text("LOADING"),);
        }
      }
    },
      // TODO refactor this into Bloc?
      stream: LaunchService().getUpcomingLaunches(),
    );

    // backgroundColor: Colors.dark,
  }
}
