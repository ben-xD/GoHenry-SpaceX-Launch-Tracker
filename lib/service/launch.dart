import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/repo/SpaceX.dart';

class LaunchService {
  // TODO save this to a shared prefs
  Set<String> _launchMissionsFlightNumbers = {};
  Map<String, LaunchMission> flightNumberToLaunchMission = Map();
  
  Stream<List<LaunchMission>> getUpcomingLaunches() {
    var repo = SpaceXRepository();
    return repo.getUpcomingLaunches();
  }

  Set<LaunchMission> getFavorites() {
    return flightNumberToLaunchMission.map((key, value) => _launchMissionsFlightNumbers.contains(key));
    return _launchMissionsFlightNumbers.map((e) => flightNumberToLaunchMission[e]).toSet();
  }
  
  void addToFavorites(LaunchMission mission) {
    _launchMissionsFlightNumbers.add(mission.flightNumber);
  }

  void removeFromFavorites(LaunchMission mission) {
    _launchMissionsFlightNumbers.remove(mission.flightNumber);
  }
}