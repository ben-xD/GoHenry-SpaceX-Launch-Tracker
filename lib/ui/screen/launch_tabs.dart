import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/service/launch.dart';
import 'package:space_time/ui/screen/launch_information.dart';
import 'package:space_time/ui/screen/launch_countdown.dart';

class LaunchTabs extends StatefulWidget {
  LaunchMission launchMission;

  LaunchTabs(this.launchMission);

  @override
  State<StatefulWidget> createState() => LaunchTabsState();
}

class LaunchTabsState extends State<LaunchTabs> with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isFavorite = false;

  @override
  void initState() {
    var service = LaunchService();
    _isFavorite = service.getFavorites().contains(this.widget.launchMission);
    _tabController = TabController(length: 2, vsync: this);
  }

  // TODO share item
  void _createShareIntent() {
    print("CREATE SHARE INTENT");
  }

  Widget star() {
    service.getFavorites().contains(this.widget.launchMission)
    var icon = isFavorite ? Icons.star : Icons.star_border;
      // TODO save to shared preferences list

    return IconButton(icon: Icon(icon), onPressed: () {
      print("SAVE TO SHARED PREFS");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          star()
        ],
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              child: Text("Countdown".toUpperCase()),
            ),
            Tab(
              child: Text("Information".toUpperCase()),
            )
          ],
        ),
        brightness: Brightness.dark,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(83, 201, 193, 1),
                Color.fromRGBO(96, 109, 120, 1)
              ])),
        ),
        toolbarHeight: 100,
        title: Text(
          this.widget.launchMission.name,
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [LaunchCountdown(this.widget.launchMission), LaunchInformation(this.widget.launchMission)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createShareIntent,
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.share,),
      ),
    );
  }
}
