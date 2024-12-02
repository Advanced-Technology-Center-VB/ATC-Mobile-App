/*

import 'dart:math';

import 'package:atc_mobile_app/contracts/notification_service_contract.dart';
import 'package:atc_mobile_app/models/event_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

///This service handles sending notifications to the device.
///All this code is pretty self explanatory, just refer to the docs: https://pub.dev/packages/flutter_local_notifications
class NotificationService extends NotificationServiceContract {
  var plugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    initPlugin();
  }

  void initPlugin() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/New_York'));

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await plugin.initialize(initializationSettings);

    var platformImpl = plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    platformImpl?.requestNotificationsPermission();
    platformImpl?.requestExactAlarmsPermission();

    platformImpl?.createNotificationChannel(const AndroidNotificationChannel(
      "event-push-notif", //id
      "Event notifications", //name
      importance: Importance.max
    ));
  }

  @override
  void sendMessageNotification(String message) {
    
  }

  @override
  void scheduleEventNotification(EventModel model, int mask) async {
    var times = [
      model.startTimestamp.subtract(const Duration(days: 1)),      // One day before
      model.startTimestamp.subtract(const Duration(hours: 12)),    // Twelve hours before
      model.startTimestamp.subtract(const Duration(hours: 6)),     // Six hours before
      model.startTimestamp.subtract(const Duration(hours: 1)),     // 1 hour before
      model.startTimestamp.subtract(const Duration(minutes: 10)),  // 10 minutes before
      model.startTimestamp,
    ];

    const messages = [
      "in 1 day",
      "in 12 hours",
      "in 6 hours",
      "in 1 hour",
      "in 10 minutes",
      "now"
    ];

    for (var i = 0; i < times.length; i++) {
      if (mask >> i & 1 == 0) continue;

      await plugin.zonedSchedule(
        Random().nextInt(100),
        "🔔 Heads up! 🔔", 
        "The event '${model.title}' begins ${messages[i]}!", 
        tz.TZDateTime.from(times[i], tz.getLocation('America/New_York')), 
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'event-push-notif', 
            'Event notifications'
          )
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.alarmClock
      );
    }
  }
}
*/