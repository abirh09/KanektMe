String formatDateTime(DateTime dateTime) {
  final List<String> monthAbbreviations = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  int hour = dateTime.hour;
  String ampm = 'AM';

  if (hour >= 12) {
    ampm = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }
  if (hour == 0) {hour = 12;}

  String formattedHour = hour.toString().padLeft(2, '0');
  String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
  String formattedDay = dateTime.day.toString();
  String formattedMonth = monthAbbreviations[dateTime.month - 1];
  String formattedYear = dateTime.year.toString();

  return '$formattedHour:$formattedMinute $ampm, $formattedDay $formattedMonth $formattedYear';
}