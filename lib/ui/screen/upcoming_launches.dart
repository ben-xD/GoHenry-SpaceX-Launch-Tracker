import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/service/launch.dart';
import 'package:space_time/ui/screen/launch_mission.dart';
import 'package:space_time/ui/widget/launch_cell.dart';

class UpcomingLaunches extends StatefulHookWidget {
  final List<LaunchMission>? _launchMissions;
  final connectionState;

  UpcomingLaunches(this._launchMissions, this.connectionState);

  @override
  State<StatefulWidget> createState() => _UpcomingLaunchesState();
}

class _UpcomingLaunchesState extends State<UpcomingLaunches> {
  LaunchMission? _selectedMission;
  bool _showFavoritesOnly = false;

  void didSelectLaunchMission(LaunchMission mission) {
    setState(() {
      _selectedMission = mission;
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = useProvider(launchServiceProvider);
    return Navigator(
      pages: [
        MaterialPage(
          child: Scaffold(
            appBar: buildAppBar(service),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 56, 42, 56),
                Color.fromARGB(255, 38, 32, 48)
              ])),
              child: SafeArea(
                  child:
                      buildLaunchCells(this.widget._launchMissions, service)),
            ),
          ),
        ),
        if (_selectedMission != null)
          MaterialPage(child: LaunchMissionScreen(_selectedMission!))
      ],
      onPopPage: (route, result) {
        _selectedMission = null;
        return route.didPop(result);
      },
    );
  }

  Widget buildLaunchCells(
      List<LaunchMission>? missions, LaunchService service) {
    if (missions != null) {
      return StreamBuilder(
          stream: service.getFavoriteLaunchMissionsStream(),
          builder: (context, snapshot) {
            return ListView(
              padding: EdgeInsets.only(top: 16),
              children: missions
                  .where((mission) =>
              _showFavoritesOnly ? service.isFavorite(mission) : true)
                  .map((e) => LaunchCell(e, didSelectLaunchMission))
                  .toList(),
            );
          });

    }
    return ListView(padding: EdgeInsets.only(top: 16), children: [
      LaunchCellSkeleton(),
      LaunchCellSkeleton(),
      LaunchCellSkeleton(),
      LaunchCellSkeleton(),
      LaunchCellSkeleton(),
      LaunchCellSkeleton(),
    ]);
  }

  AppBar buildAppBar(LaunchService service) {
    return AppBar(
      brightness: Brightness.dark,
      actions: [buildFavoritesIcon(service)],
      backwardsCompatibility: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(172, 85, 138, 1),
          Color.fromRGBO(64, 22, 86, 1)
        ])),
      ),
      toolbarHeight: 100,
      title: Text(
        "Upcoming Launches",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Padding buildFavoritesIcon(LaunchService service) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: IconButton(
          icon: StreamBuilder<Set<LaunchMission>>(
              stream: service.getFavoriteLaunchMissionsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Badge(
                    badgeColor: Colors.white,
                    badgeContent: Text(
                      "${snapshot.data!.length}",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    child: Icon(_showFavoritesOnly
                        ? Icons.bookmarks
                        : Icons.bookmarks_outlined),
                  );
                }
                return CupertinoActivityIndicator();
              }),
          onPressed: () {
            setState(() {
              _showFavoritesOnly = _showFavoritesOnly ? false : true;
            });
          }),
    );
  }
}
