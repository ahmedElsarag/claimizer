import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';

class TimeFormatUtil {
  static String durationFormat(int duration) {
    var minute = duration ~/ 60;
    var second = duration % 60;
    if (minute <= 9) {
      if (second <= 9) {
        return "0$minute' 0$second''";
      } else {
        return "0$minute' $second''";
      }
    } else {
      if (second <= 9) {
        return "$minute' 0$second''";
      } else {
        return "$minute' $second''";
      }
    }
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('hh:mm ');
    String timeString = format.format(dt);
    final hour = tod.hour;
    final minute = tod.minute;
    if (hour >= 12) {
      timeString = timeString.replaceFirst(RegExp(r'^0+'), (hour - 12).toString());
      timeString += S.current.evening;
    } else {
      timeString += S.current.morning;
    }
    return timeString;
  }
}
