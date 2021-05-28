import 'package:meta/meta.dart';
import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';

class MessageModel {
  String? userId;
  String? id;
  bool? isPending = false;
  dynamic? senderId;
  dynamic msgContent;
  dynamic sendTime;
  dynamic? senderName;
  MessageModel(
      {this.userId,
      this.id,
      this.senderId,
      this.isPending,
      this.sendTime,
      this.msgContent,
      this.senderName});
  factory MessageModel.fromJson({required Map<dynamic, dynamic> map}) {
    return new MessageModel(
      userId: map[GeneralConstants.userId],
      id: map[GeneralConstants.id],
      sendTime: map[GeneralConstants.createdAt],
      senderId: map[GeneralConstants.senderId],
      senderName: map[GeneralConstants.senderName],
      msgContent: map[GeneralConstants.msgContent],
    );
  }

  factory MessageModel.fromMap(Map<dynamic, dynamic> map) => MessageModel(
        userId: map[GeneralConstants.userId],
        id: map[GeneralConstants.id],
        senderId: map[GeneralConstants.senderId],
        senderName: map[GeneralConstants.senderName],
        msgContent: map[GeneralConstants.msgContent],
      );
}
