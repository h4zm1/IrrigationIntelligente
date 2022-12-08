import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/Result.dart';
import 'package:irregation/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future init() async {
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: androidSettings);
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      Get.to(ResultPage(result: 'result'));
    }
    await _notification.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null && details.payload != "none") {
          Get.to(ResultPage(result: details.payload!));
        }
      },
    );
  }

  static Future _notificationDetails({String? image, String? icon}) async {
    final String largeIconPath = await _downloadAndSaveFile(
        icon ?? 'https://via.placeholder.com/48x48', 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(
        image ?? 'https://via.placeholder.com/400x800', 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'big text channel id 2', 'big text channel name',
            channelDescription: 'big text channel description',
            importance: Importance.max,
            playSound: false,
            styleInformation: bigPictureStyleInformation);
    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
  }

  static void showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? image,
    String? icon,
    String? payload,
    required tz.TZDateTime scheduledDate,
  }) async {
    _notification.zonedSchedule(id, title, body, scheduledDate,
        await _notificationDetails(image: image, icon: icon),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void showDailyScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? image,
    String? icon,
    required Time scheduledDate,
  }) async {
    _notification.zonedSchedule(id, title, body, _scheduleDaily(scheduledDate),
        await _notificationDetails(image: image, icon: icon),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload);
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    print(now);
    final secheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour - 1, time.minute, time.second);
    print(secheduledDate.isBefore(now)
        ? secheduledDate.add(Duration(days: 1))
        : secheduledDate);
    return secheduledDate.isBefore(now)
        ? secheduledDate.add(Duration(days: 1))
        : secheduledDate;
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static void cancelAll() => _notification.cancelAll();
}
