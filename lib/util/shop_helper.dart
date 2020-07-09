class Money {
  num amount;
  Money(this.amount);

  Money operator +(Money other) {
    return Money(amount + other.amount);
  }

  Money operator *(num other) {
    return Money(amount * other);
  }

  @override
  String toString() {
    String sPrice = amount.toStringAsFixed(2);
    return "R $sPrice";
  }
}

String formatDateTime(DateTime dateTime) {
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  List weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  int hours = ((dateTime.hour) < 13) ? dateTime.hour : (dateTime.hour - 12);
  String suf = ((dateTime.hour) < 12) ? 'a.m' : 'p.m';
  String year =
      ((dateTime.year) == DateTime.now().year) ? '' : ' ${dateTime.year}';
  return '${weekdays[dateTime.weekday - 1]}, ${months[dateTime.month - 1]} ${dateTime.day}$year, $hours:${dateTime.minute} $suf.';
}