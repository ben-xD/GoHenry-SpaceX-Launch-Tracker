import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:space_time/model/launch_mission.dart';
import 'package:space_time/util/hook_infinite_timer.dart';

class LaunchCountdown extends HookWidget {
  final LaunchMission launchMission;

  LaunchCountdown(this.launchMission);

  Widget getCountdown(BuildContext context, Duration timeDifference, Color color) {
    useInfiniteTimer(context);

    return OrientationBuilder(builder: (context, orientation) {
      var mainAxis = (orientation == Orientation.landscape)
          ? Axis.horizontal
          : Axis.vertical;
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 48),
        child: Flex(
            direction: mainAxis,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTicker(timeDifference.inDays, color: color),
                  // if (mainAxis == Axis.vertical) Spacer(),
                  getLabel("Days", color: color),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTicker(timeDifference.inHours % 24, color: color),
                  // if (mainAxis == Axis.vertical) Spacer(),
                  getLabel("Hours", color: color),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTicker(timeDifference.inMinutes % 60, color: color),
                  getLabel("Minutes", color: color),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTicker(timeDifference.inSeconds % 60, color: color),
                  getLabel("Seconds", color: color),
                ],
              ),
            ]),
      );
    });
  }

  Widget getLabel(String text, {Color color = Colors.black}) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Text(text.toUpperCase(),
          style: TextStyle(fontSize: 20, color: color)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0)),
    );
  }

  Widget getTicker(int number, {Color color = Colors.black}) {
    return Column(
      children: [
        Text(
          "${number.toString().padLeft(2, '0')}",
          style: TextStyle(fontSize: 100, fontFamily: "Digital-7", color: color),
        ),
        if (Platform.isAndroid) SizedBox(height: 16,),
      ],
    );
  }

  Widget _getCountdownColumn(BuildContext context,
      {Color color = Colors.black}) {
    var timeDifference =
    launchMission.datetime.difference(DateTime.now());
    if (launchMission.datetime.isAfter(DateTime.now())) {
      return SizedBox.expand(
        child: getCountdown(context, timeDifference, color),
      );
    } else {
      return Column(
        children: [
          Spacer(),
          Text("Uncertain launch time...", style: Theme
              .of(context)
              .textTheme
              .headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "It will happen sometime this ${EnumToString.convertToString(
                launchMission.datePrecision, camelCase: true)
                .toLowerCase()} or has already happened.",
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1,),
          Spacer(),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 34, 66, 68),
              Color.fromARGB(255, 55, 65, 69)
            ])),
        child: _getCountdownColumn(context, color: Colors.white));
  }
}