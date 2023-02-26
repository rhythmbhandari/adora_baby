import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notiPlugin =
      FlutterLocalNotificationsPlugin();

  static String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null) {
      return notification.apple?.imageUrl;
    }
    if (Platform.isAndroid && notification.android != null) {
      return notification.android?.imageUrl;
    }
    return null;
  }

  static Future<String?> _downloadAndSavePicture(
      String? url, String fileName) async {
    if (url == null) return null;
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  // NotificationDetails _buildDetails(String title, String body, String? picturePath, bool showBigPicture) {
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     _channel.id,
  //     _channel.name,
  //     channelDescription: _channel.description,
  //     styleInformation: _buildBigPictureStyleInformation(title, body, picturePath, showBigPicture),
  //     importance: _channel.importance,
  //     icon: "notification_icon",
  //   );
  //   final IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //     attachments: [if (picturePath != null) IOSNotificationAttachment(picturePath)],
  //   );
  //   final NotificationDetails details = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );
  //   return details;
  // }
  static BigPictureStyleInformation? _buildBigPictureStyleInformation(
    String title,
    String body,
    String? picturePath,
    bool showBigPicture,
  ) {
    if (picturePath == null) return null;
    final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
    return BigPictureStyleInformation(
      showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
      largeIcon: filePath,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
  }

  static void initialize() {
    const InitializationSettings initialSettings = InitializationSettings(
        android: AndroidInitializationSettings(
          '@drawable/ic_firebase_notification',
        ),
        iOS: DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        ));
    _notiPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {});
  }

  static void showNotification(RemoteMessage message) async {
    String imagePath = _getImageUrl(message.notification!) ?? '';
    var picturePath = '';
    if (imagePath.isNotEmpty) {
      picturePath = await _downloadAndSavePicture(
              imagePath, message.notification?.title ?? 'adora_ad') ??
          '';
    }
    NotificationDetails notiDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          message.notification?.android?.channelId ??
              'com.adora_baby.adora_baby',
          'Adora Baby',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: _buildBigPictureStyleInformation(
            message.notification?.title ?? '',
            message.notification?.body ?? '',
            picturePath,
            picturePath.isEmpty ? false : true,
          ),
        ),
        iOS: const DarwinNotificationDetails());
    _notiPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notiDetails,
      payload: message.data.toString(),
    );
  }
}
