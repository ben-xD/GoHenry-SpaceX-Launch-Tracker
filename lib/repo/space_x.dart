import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_time/model/launch_mission.dart';

var _baseUrl = "https://api.spacexdata.com/v4";
class SpaceXRepository {
  Future<List<LaunchMission>> getUpcomingLaunches() async {
    var url = Uri.parse(_baseUrl + "/launches/upcoming");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> launchMissionsJson = jsonDecode(response.body);
      return launchMissionsJson
          .map((mission) => LaunchMission.fromJson(mission)).toList();
    }
    return Future.error("Unable to get data");
    // Stream.fromIterable([
    //   LaunchMission("Starlink 6", DateTime(2020, 09, 20)),
    //   LaunchMission("ANASIS-II", DateTime(2020, 10, 04)),
    // ]);
  }
}