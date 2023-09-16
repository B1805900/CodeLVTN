import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_classroom_management/app/data/helper/datetime_helpers.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<void> makeNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> createReminderNotification(
    DateTime reminder, String doctorName, DateTime bookingTime) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: "${Emojis.office_calendar} Cuộc hẹn sắp đến!",
      body:
          'Bạn có cuộc hẹn với bác sĩ ${doctorName} vào ${DateTimeHelpers.dateTimeToTime(bookingTime)}',
      displayOnBackground: true,
      displayOnForeground: true,
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule: NotificationCalendar.fromDate(date: reminder),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
