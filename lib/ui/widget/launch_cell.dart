import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:space_time/model/launch_mission.dart';

class LaunchCell extends StatelessWidget {
  final LaunchMission _launchMission;
  final ValueChanged<LaunchMission> _didSelect;
  final Color textColor;

  const LaunchCell(this._launchMission, this._didSelect,
      {this.textColor = Colors.white, Key? key})
      : super(key: key);

  Widget getDate() {
    String text;
    switch (_launchMission.datePrecision) {
      case DatePrecision.year:
        text = "${Jiffy(_launchMission.datetime).year}";
        break;
      case DatePrecision.half_year:
        if (Jiffy(_launchMission.datetime).month <= 6) {
          text = "${Jiffy(_launchMission.datetime).year}";
        } else {
          text = "${Jiffy(_launchMission.datetime).year}";
        }
        break;
      case DatePrecision.quarter:
        text = "Q${Jiffy(_launchMission.datetime).quarter}";
        break;
      case DatePrecision.month:
        text = "${DateFormat.MMMM().format(_launchMission.datetime)}";
        break;
      case DatePrecision.day:
        text = Jiffy(_launchMission.datetime).fromNow();
        break;
      case DatePrecision.hour:
        text = Jiffy(_launchMission.datetime).fromNow();
        break;
      case DatePrecision.unknown:
        text = Jiffy(_launchMission.datetime).fromNow();
        break;
    }

    return Text(
      text,
      textAlign: TextAlign.right,
      style: TextStyle(fontSize: 20, color: textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  child: Text(_launchMission.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 18),
                  getDate(),
                  SizedBox(width: 18),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromRGBO(172, 85, 138, 1),
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () => _didSelect(_launchMission));
  }
}

class LaunchCellSkeleton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 21),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).accentColor,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                height: 32,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                height: 32,
              ),
            ),
          ],
        ),),
    );
  }
}
