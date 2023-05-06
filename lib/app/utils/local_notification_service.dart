import 'dart:io';

import 'package:adora_baby/app/data/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'secure_storage.dart';

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
    final Dio dio = Dio();
    final Response<List<int>?> response = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final List<int> data = response.data ?? [];
    final File file = File(filePath);
    await file.writeAsBytes(data);
    return filePath;
  }


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
