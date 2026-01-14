import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'dart:io';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _logger = Logger('NotificationService');

  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    tz.initializeTimeZones();
    String? timeZoneName;
    try {
      final dynamic detected = await FlutterTimezone.getLocalTimezone();
      timeZoneName = detected.toString();
      _logger.info('Local timezone detected: $timeZoneName');
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      _logger.warning('Failed to get local timezone "$timeZoneName", trying fallback', e);
      try {
        final deviceTimeZone = DateTime.now().timeZoneName;
        tz.setLocalLocation(tz.getLocation(deviceTimeZone));
        _logger.info('Fallback to device timeZoneName successful: $deviceTimeZone');
      } catch (e2) {
        _logger.warning('Fallback to device timeZoneName failed, using UTC', e2);
        tz.setLocalLocation(tz.getLocation('UTC'));
      }
    }
    
    const initializationSettingsAndroid = AndroidInitializationSettings('notification_icon');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        _logger.info('Notification tapped: ${response.payload}');
      },
    );

    // Create Notification Channels for Android
    if (Platform.isAndroid) {
      final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(const AndroidNotificationChannel(
          'medication_reminders',
          'Medikamenten-Erinnerungen',
          description: 'Erinnerungen an die Medikamentengabe',
          importance: Importance.max,
          enableVibration: true,
          playSound: true,
          showBadge: true,
        ));

        await androidPlugin.createNotificationChannel(const AndroidNotificationChannel(
          'daily_reminders',
          'Tägliche Erinnerungen',
          description: 'Erinnerungen an tägliche Aufgaben',
          importance: Importance.max,
          enableVibration: true,
          playSound: true,
          showBadge: true,
        ));

        // Request permissions for Android 13+
        final granted = await androidPlugin.requestNotificationsPermission();
        _logger.info('Notification permission granted: $granted');
        
        // Also request exact alarm permission if needed
        _logger.info('Requesting exact alarm permission');
        await androidPlugin.requestExactAlarmsPermission();
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final localDate = scheduledDate.isUtc ? scheduledDate.toLocal() : scheduledDate;
    final now = DateTime.now();
    
    if (localDate.isBefore(now.subtract(const Duration(seconds: 30)))) {
      _logger.warning('Attempted to schedule notification in the past: $localDate (Now: $now)');
      return;
    }

    var scheduledTZDate = tz.TZDateTime(
      tz.local,
      localDate.year,
      localDate.month,
      localDate.day,
      localDate.hour,
      localDate.minute,
      localDate.second,
    );

    final nowTZ = tz.TZDateTime.now(tz.local);
    if (scheduledTZDate.isBefore(nowTZ)) {
       scheduledTZDate = nowTZ.add(const Duration(seconds: 5));
    }

    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final bool hasPermission = (await androidPlugin?.canScheduleExactNotifications()) ?? false;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTZDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_reminders',
          'Medikamenten-Erinnerungen',
          channelDescription: 'Erinnerungen an die Medikamentengabe',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: hasPermission 
          ? AndroidScheduleMode.exactAllowWhileIdle 
          : AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final bool hasPermission = (await androidPlugin?.canScheduleExactNotifications()) ?? false;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminders',
          'Tägliche Erinnerungen',
          channelDescription: 'Erinnerungen an tägliche Aufgaben',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: hasPermission 
          ? AndroidScheduleMode.exactAllowWhileIdle 
          : AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    _logger.info('Notification $id cancelled');
  }
}
