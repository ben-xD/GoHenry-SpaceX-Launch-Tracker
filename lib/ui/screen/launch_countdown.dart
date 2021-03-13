import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:space_time/model/launch_mission.dart';

class LaunchCountdown extends StatefulWidget {
  final LaunchMission launchMission;

  LaunchCountdown(this.launchMission);

  @override
  State<StatefulWidget> createState() => _LaunchCountdownState();
}

class _LaunchCountdownState extends State<LaunchCountdown> {
  Timer? updateEverySecond;

  @override
  void initState() {
    updateEverySecond = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    updateEverySecond?.cancel();
    super.dispose();
  }

  Widget getCountdownList(Duration timeDifference, Color color) {
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
    return Text(
      "${number.toString().padLeft(2, '0')}",
      style: TextStyle(fontSize: 100, fontFamily: "Digital-7", color: color),
    );
  }

  Widget _getCountdownColumn({Color color = Colors.black}) {
    var timeDifference =
        this.widget.launchMission.datetime.difference(DateTime.now());
    if (this.widget.launchMission.datetime.isAfter(DateTime.now())) {
      return SizedBox.expand(
        child: getCountdownList(timeDifference, color),
      );
    } else {
      return Column(
        children: [
          Spacer(),
          Text("Uncertain launch time...", style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 8),
          Text(
              "It will happen sometime this ${EnumToString.convertToString(this.widget.launchMission.datePrecision, camelCase: true).toLowerCase()}.",
          style: Theme.of(context).textTheme.bodyText1,),
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
          child: _getCountdownColumn(color: Colors.white));
  }
}
