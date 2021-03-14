import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share/share.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/service/launch.dart';
import 'package:space_time/ui/screen/launch_information.dart';
import 'package:space_time/ui/screen/launch_countdown.dart';

class LaunchMissionScreen extends HookWidget {
  final LaunchMission launchMission;
  LaunchMissionScreen(this.launchMission);

  void _createShareIntent() {
    Share.share("SpaceX's ${launchMission.name} launches at ${launchMission.datetime}, accurate to ${EnumToString.convertToString(launchMission.datePrecision, camelCase: true).toLowerCase()}");
  }

  Widget star(AsyncSnapshot<Set<LaunchMission>> snapshot, LaunchService service) {
    if (snapshot.hasData) {
      bool isFavorite = snapshot.data!.contains(launchMission);
      var icon = isFavorite ? Icons.star : Icons.star_border;
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(icon: Icon(icon), onPressed: () {
          isFavorite ? service.removeFromFavorites(launchMission) : service.addToFavorites(launchMission);
        }),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = useProvider(launchServiceProvider);
    final launchMissionFavorites = useStream<Set<LaunchMission>>(
        service.getFavoriteLaunchMissionsStream(), initialData: Set());
    final tickerProvider = useSingleTickerProvider();
    final tabController = useTabController(
        initialLength: 2, vsync: tickerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          star(launchMissionFavorites, service)
        ],
        bottom: TabBar(
          controller: tabController,
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
          launchMission.name,
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          LaunchCountdown(launchMission),
          LaunchInformation(launchMission)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createShareIntent,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        child: Icon(Icons.share,),
      ),
    );
  }
}
