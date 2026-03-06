import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('Notification tapped: ${details.payload}');
      },
    );

    // Create the habit tracker channel explicitly
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'habit_tracker_channel',
      'Habit Tracker Reminders',
      description: 'Notifications for your daily habits',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Request permissions for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    
    final bool? exactAlarms = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    debugPrint('Exact alarms permission: $exactAlarms');
  }

  static Future<void> schedulePeriodicNotification({
    required int id,
    required String title,
    required String body,
    required int intervalInMinutes,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'habit_tracker_channel',
      'Habit Tracker Reminders',
      channelDescription: 'Notifications for your daily habits',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    // 1. Show an immediate confirmation so the user knows it's active
    await _notificationsPlugin.show(
      id + 1000, // Different ID for confirmation
      'Reminder Active!',
      'I will remind you about "$title" every $intervalInMinutes mins.',
      platformDetails,
    );

    // 2. Schedule the first one using zonedSchedule for better reliability
    // and let periodicallyShow handle the rest.
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime firstSchedule = now.add(Duration(minutes: intervalInMinutes));

    // For "every 1 minute", periodicallyShow is usually fine if permissions are OK.
    // However, exact alarms are needed for precise timing.
    await _notificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      intervalInMinutes == 1 ? RepeatInterval.everyMinute : RepeatInterval.hourly,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    debugPrint('Periodic notification scheduled with ID: $id');
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  static Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(id, title, body, platformDetails);
  }
}
