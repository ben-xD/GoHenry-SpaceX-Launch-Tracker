
import 'package:flutter/cupertino.dart';
import 'package:space_time/model/launch_mission.dart';

class LaunchInformation extends StatelessWidget {
  final LaunchMission launchMission;

  LaunchInformation(this.launchMission);

  @override
  Widget build(BuildContext context) => Text("Information");

}