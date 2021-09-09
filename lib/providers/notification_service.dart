import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/providers/scheduled_medications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService with ChangeNotifier {
  FlutterLocalNotificationsPlugin _notificationsPlugin;
  ScheduledMedications _scheduledMedicationsProvider;
  Profiles _profilesProvider;

  NotificationService(ScheduledMedications scheduledMedicationsProvider,
      Profiles profilesProvider) {
    _scheduledMedicationsProvider = scheduledMedicationsProvider;
    _profilesProvider = profilesProvider;
    var androidSettings = AndroidInitializationSettings('app_icon');
    var iosSettings = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _notificationsPlugin.initialize(initializationSettings).then(
      (_) {
        // cancelAllNotifications();

        if (_scheduledMedicationsProvider != null &&
            _profilesProvider != null) {
          for (final profile in _profilesProvider.profiles) {
            if (!profile.notificationsOn) continue;
            _scheduledMedicationsProvider.fetch(profile.id).then(
              (medications) {
                for (final item in medications) {
                  recurringNotification(
                    id: item.id,
                    title: '${profile.firstName}, lembrete de medicamento',
                    body:
                        "${item.nomeComercial} às ${item.hour}:${item.minute.toString().padLeft(2, '0')}",
                    dateTime: tz.TZDateTime.from(
                      DateTime(2021, 1, 1, item.hour, item.minute),
                      tz.local,
                    ),
                  );
                }
              },
            );
          }
        }
      },
    );
  }

  // Future instantNofitication() async {
  //   var androidNotification = AndroidNotificationDetails(
  //     "id",
  //     "channel",
  //     "description",
  //   );
  //   var iosNotification = IOSNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   var platform = new NotificationDetails(
  //     android: androidNotification,
  //     iOS: iosNotification,
  //   );
  //   await _notificationsPlugin.show(
  //     0,
  //     "Demo instant notification",
  //     "Tap to do something",
  //     platform,
  //     payload: "Welcome to demo app",
  //   );
  // }

  // Future imageNotification() async {
  //   var bigPicture = BigPictureStyleInformation(
  //       DrawableResourceAndroidBitmap("ic_launcher"),
  //       largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
  //       contentTitle: "Demo image notification",
  //       summaryText: "This is some text",
  //       htmlFormatContent: true,
  //       htmlFormatContentTitle: true);

  //   var android = AndroidNotificationDetails("id", "channel", "description",
  //       styleInformation: bigPicture);

  //   var platform = new NotificationDetails(android: android);

  //   await _notificationsPlugin.show(
  //       0, "Demo Image notification", "Tap to do something", platform,
  //       payload: "Welcome to demo app");
  // }

  // Future stylishNotification() async {
  //   var android = AndroidNotificationDetails(
  //     "id",
  //     "channel",
  //     "description",
  //     color: Colors.deepOrange,
  //     enableLights: true,
  //     enableVibration: true,
  //     largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
  //     styleInformation: MediaStyleInformation(
  //       htmlFormatContent: true,
  //       htmlFormatTitle: true,
  //     ),
  //   );

  //   var platform = new NotificationDetails(android: android);

  //   await _notificationsPlugin.show(
  //     0,
  //     "Demo Stylish notification",
  //     "Tap to do something",
  //     platform,
  //   );
  // }

  Future recurringNotification({
    @required String title,
    @required String body,
    @required dynamic dateTime,
    @required int id,
  }) async {
    var androidNotification = AndroidNotificationDetails(
      "id",
      "channel",
      "description",
    );
    var iosNotification = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platform = new NotificationDetails(
      android: androidNotification,
      iOS: iosNotification,
    );
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      dateTime,
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Future scheduledNotification() async {
  //   var androidNotification = AndroidNotificationDetails(
  //     "id",
  //     "channel",
  //     "description",
  //   );
  //   var iosNotification = IOSNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   final notificationDetails = NotificationDetails(
  //     android: androidNotification,
  //     iOS: iosNotification,
  //   );

  //   _notificationsPlugin.zonedSchedule(
  //     0,
  //     'title',
  //     'body',
  //     tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
  //     notificationDetails,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //   );
  // }

  // Future cancelAllNotifications() async {
  //   await _notificationsPlugin.cancelAll();
  // }
}
