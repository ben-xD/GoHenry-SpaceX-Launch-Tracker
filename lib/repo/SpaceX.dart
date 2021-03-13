import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_time/model/launch_mission.dart';

var _baseUrl = "https://api.spacexdata.com/v4";
class SpaceXRepository {
  Stream<List<LaunchMission>> getUpcomingLaunches() async* {
    var url = Uri.parse(_baseUrl + "/launches/upcoming");
    var response = await http.get(url);
    // await Future.delayed(Duration(seconds: 2));
    // TODO handle error?
    if (response.statusCode == 200) {
      // TODO convert into LaunchMission
      List<dynamic> launchMissionsJson = jsonDecode(response.body);
      yield launchMissionsJson
          .map((mission) => LaunchMission.fromJson(mission)).toList();
    }
    // Stream.fromIterable([
    //   LaunchMission("Starlink 6", DateTime(2020, 09, 20)),
    //   LaunchMission("ANASIS-II", DateTime(2020, 10, 04)),
    // ]);
  }
}