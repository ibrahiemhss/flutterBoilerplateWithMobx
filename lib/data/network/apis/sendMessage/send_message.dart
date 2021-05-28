import 'dart:async';
import 'dart:convert';

import 'package:flutterBoilerplateWithMobx/data/network/constants/endpoints.dart';
import 'package:flutterBoilerplateWithMobx/data/network/dio_client.dart';
import 'package:flutterBoilerplateWithMobx/data/network/rest_client.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/fcm_notification_model.dart';
import 'package:flutterBoilerplateWithMobx/models/post/post_list.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class SendMessageApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  SendMessageApi(this._dioClient, this._restClient);

  /// Returns Message in response
  Future<String> sendAndRetrieveFcmMessage(FcmMessage fcmMessage) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': "key=${Endpoints.fcmServerKey}"
    };
    final data = jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          // "click_action": "FLUTTER_NOTIFICATION_CLICK",
          'body': fcmMessage.body,
          'title': fcmMessage.title,
          "image": "null",
          //  "android_channel_id": "default_notification_channel_id",
          //  "channel_id": "default_notification_channel_id",
          //  "sound": "alert.mp3"
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'senderName': fcmMessage.senderName,
          'status': 'done',
          'body': fcmMessage.body,
          'title': fcmMessage.title,
          "image": "",
          'type': fcmMessage.type,
        },
        'token': fcmMessage.deviceRegId,
        'to': fcmMessage.deviceRegId,
        "apns": {
          "payload": {
            "aps": {"mutable-content": 1}
          },
          "fcm_options": {"image": ""}
        }
      },
    );

    try {
      final res = await _restClient.post(Endpoints.fcmUrl,
          headers: headers, body: data);
      return res.toString();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
