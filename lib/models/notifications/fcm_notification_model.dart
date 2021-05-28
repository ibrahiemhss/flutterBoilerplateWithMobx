// To parse this JSON data, do
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

String FcmMessageToJson(FcmMessage? data) {
  if (data! != null) {
    return json.encode(data.toJson());
  } else {
    return "null";
  }
}

class FcmMessage {
  String? deviceRegId;
  String? title;
  String? body;
  String? image;
  String? senderName;
  String? sentAt;
  String? type;

  FcmMessage({
    this.deviceRegId,
    this.title,
    this.body,
    this.image,
    this.senderName,
    this.sentAt,
    this.type,
  });

  factory FcmMessage.fromJson(Map<String, dynamic> json) => FcmMessage(
        type: json["data"]["type"] ?? "",
        deviceRegId: json["data"]["deviceRegId"] ?? "",
        title: json["data"]["title"] ?? "",
        body: json["data"]["body"] ?? "",
        image: json["data"]["image"] ?? "",
        senderName: json["data"]["senderName"] ?? "",
        sentAt: json["data"]["sentAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "deviceRegId": deviceRegId,
        "title": title,
        "body": body,
        "image": image,
        "senderName": senderName,
        "sentAt": sentAt,
      };
}
