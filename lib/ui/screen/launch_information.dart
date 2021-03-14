
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_time/model/launch_mission.dart';

class LaunchInformation extends StatelessWidget {
  final LaunchMission launchMission;

  LaunchInformation(this.launchMission);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Information", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3,),
      Text("I was going to add a map here, but coordinates were not provided by the API.", textAlign: TextAlign.center,)
    ],
  );

}