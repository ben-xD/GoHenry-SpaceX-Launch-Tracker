import 'package:quiver/core.dart';

class LaunchMission {
  final String flightNumber;
  final String name;
  final DateTime datetime;
  final DatePrecision datePrecision;
  final Map<String, String?> imageUris;

  const LaunchMission(this.flightNumber, this.name, this.datetime, this.datePrecision,
      this.imageUris);

  factory LaunchMission.fromJson(Map<String, dynamic> json) {
    return LaunchMission(
        json["flight_number"].toString(),
        json["name"],
        DateTime.fromMillisecondsSinceEpoch(json["date_unix"] * 1000),
        DatePrecisionExtension.fromString(json["date_precision"]),
        Map<String, String?>.from(json["links"]["patch"])
    );
  }

  @override
  bool operator ==(Object other) {
    return (other is LaunchMission)
      && flightNumber == other.flightNumber;
  }

  @override
  int get hashCode => hash2(flightNumber, name);

}

enum DatePrecision {
  year,
  half_year,
  quarter,
  month,
  day,
  hour,
  unknown,
}

extension DatePrecisionExtension on DatePrecision {
  static DatePrecision fromString(datePrecision) {
    switch (datePrecision) {
      case "year":
        return DatePrecision.year;
      case "half":
        return DatePrecision.half_year;
      case "quarter":
        return DatePrecision.quarter;
      case "month":
        return DatePrecision.month;
      case "day":
        return DatePrecision.day;
      case "hour":
        return DatePrecision.hour;
      default:
        return DatePrecision.unknown;
    }
  }
}