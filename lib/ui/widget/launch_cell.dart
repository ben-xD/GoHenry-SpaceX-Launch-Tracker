import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:space_time/model/launch_mission.dart';

class LaunchCell extends StatelessWidget {
  final LaunchMission _launchMission;
  final ValueChanged<LaunchMission> _didSelect;
  final Color textColor;

  const LaunchCell(this._launchMission, this._didSelect,
      {this.textColor = Colors.white, Key? key})
      : super(key: key);

  // Widget getDate() {
  //   return Text("${launchMission.datetime.day}/${launchMission.datetime.month}/${launchMission.datetime.year.toString().substring(2)}",
  //     style: TextStyle(fontSize: 14),);
  // }

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
      style: TextStyle(fontSize: 20, color: textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    var imageUri =
        _launchMission.imageUris["small"] ?? _launchMission.imageUris["large"];
    // Old code for showing image. TODO use this in countdown screen
    // if (imageUri != null) Padding(
    //   padding: const EdgeInsets.only(right: 16.0),
    //   child: Image.network(launchMission.imageUris["small"], width: 40,),
    // ),

    // TODO add a screen when tapped/ navigation
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
          child: Row(
            children: [
              Text(
                _launchMission.name,
                style: Theme.of(context).textTheme.bodyText1
              ),
              // TODO wrap text if too big
              Spacer(),
              // TODO change text to human readable
              getDate(),
              SizedBox(width: 18),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color.fromRGBO(172, 85, 138, 1),
              )
            ],
          ),
        ),
        onTap: () => _didSelect(_launchMission));
  }
}
