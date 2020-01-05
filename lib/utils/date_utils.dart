class DateUtils{
  static int getHourFromMillis(int time){
    return DateTime.fromMillisecondsSinceEpoch(time * 1000).hour;
  }
  static int getDayFromMillis(int time){
    return DateTime.fromMillisecondsSinceEpoch(time * 1000).day;
  }
}