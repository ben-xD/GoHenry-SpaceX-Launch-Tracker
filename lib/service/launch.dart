import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/repo/space_x.dart';

final launchServiceProvider = Provider((_) => LaunchService());

class LaunchService {
  static const _KEY_FAVORITES = "LAUNCH_FAVORITES";
  final _favoriteBehaviorSubject = BehaviorSubject<Set<LaunchMission>>();
  final _repo = SpaceXRepository(); // TODO inject instead
  Set<LaunchMission> _favoriteLaunchMissions = {};

  LaunchService() {
    rebuildFavoritesList();
  }

  Future<List<LaunchMission>> getUpcomingLaunches() async {
    return _repo.getUpcomingLaunches();
  }

  bool isFavorite(LaunchMission mission) =>
      _favoriteLaunchMissions.contains(mission);

  Stream<Set<LaunchMission>> getFavoriteLaunchMissionsStream() {
    return _favoriteBehaviorSubject.stream;
  }

  void addToFavorites(LaunchMission mission) {
    _favoriteLaunchMissions.add(mission);
    emitLatestFavorites();
    updateSharedPreferences();
  }

  void removeFromFavorites(LaunchMission mission) {
    _favoriteLaunchMissions.remove(mission);
    emitLatestFavorites();
    updateSharedPreferences();
  }

  void updateSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var favoritesFlightNumbers =
        _favoriteLaunchMissions.map((e) => e.flightNumber).toList();
    sharedPreferences.setStringList(_KEY_FAVORITES, favoritesFlightNumbers);
  }

  void rebuildFavoritesList() async {
    _favoriteLaunchMissions = {};

    var sharedPreferences = await SharedPreferences.getInstance();
    var favoriteFlightNumbers =
        sharedPreferences.getStringList(_KEY_FAVORITES)?.toSet() ?? {};
    var favoriteMissions = await getUpcomingLaunches();
    favoriteMissions
        .where(
            (mission) => favoriteFlightNumbers.contains(mission.flightNumber))
        .forEach((mission) {
      _favoriteLaunchMissions.add(mission);
    });
    emitLatestFavorites();
  }

  void emitLatestFavorites() {
    _favoriteBehaviorSubject.add(_favoriteLaunchMissions);
  }
}
