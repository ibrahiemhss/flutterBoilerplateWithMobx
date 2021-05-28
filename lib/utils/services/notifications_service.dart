import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/fcm_notification_model.dart';

enum NOTIFICATION_TYPE { primary, info, success, danger, warning }

class NotificationsService {
  NotificationsService();

  Color? _getColorForType(NOTIFICATION_TYPE type) {
    switch (type) {
      case NOTIFICATION_TYPE.info:
        return Colors.lightBlue;
      case NOTIFICATION_TYPE.success:
        return AppColors.mainColor[500]!;
      case NOTIFICATION_TYPE.warning:
        return Colors.orange;
      case NOTIFICATION_TYPE.danger:
        return Colors.red;

      case NOTIFICATION_TYPE.primary:
      default:
        return Colors.blue;
    }
  }

  _notify({
    String? title,
    String? message,
    IconData icon = MaterialCommunityIcons.bell,
    NOTIFICATION_TYPE type = NOTIFICATION_TYPE.primary,
    int timeout = 3,
  }) {
    var textColor = Colors.white;
    showToastWidget(
      Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () => dismissAllToast(showAnim: true),
              child: Container(
                color: _getColorForType(type),
                padding: EdgeInsets.all(12),
                height: 80,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(icon == null ? MaterialCommunityIcons.bell : icon,
                        color: textColor),
                    Container(width: 8),
                    Expanded(
                      child: Text(
                        message!,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      handleTouch: true,
      duration: Duration(seconds: 10),
    );
  }

  notify({
    required String title,
    required String body,
    // @required  IconData icon,
    //@required  int timeout,
  }) {
    this._notify(
      title: title,
      message: body,
      //icon: icon,
      type: NOTIFICATION_TYPE.primary,
      // timeout: timeout,
    );
  }

  notifyInfo(
    String message, {
    String? title,
    IconData? icon,
    int? timeout,
  }) {
    this._notify(
      title: title,
      message: message,
      icon: icon!,
      type: NOTIFICATION_TYPE.info,
      timeout: timeout!,
    );
  }

  notifySuccess(
    String message, {
    String? title,
    IconData? icon,
    int? timeout,
  }) {
    this._notify(
      title: title,
      message: message,
      icon: icon!,
      type: NOTIFICATION_TYPE.success,
      timeout: timeout!,
    );
  }

  notifyWarning(
    String message, {
    String? title,
    int? timeout,
  }) {
    this._notify(
      title: title,
      message: message,
      icon: MaterialIcons.warning,
      type: NOTIFICATION_TYPE.warning,
      timeout: timeout!,
    );
  }

  notifyDanger(
    String message, {
    String? title,
    int? timeout,
  }) {
    this._notify(
      title: title,
      message: message,
      icon: MaterialIcons.warning,
      type: NOTIFICATION_TYPE.danger,
      timeout: timeout!,
    );
  }

  notifyError(
    String message, {
    String? title,
    int? timeout,
  }) {
    this.notifyDanger(
      message,
      title: title,
      timeout: timeout,
    );
  }

  void navigateToItemDetail(BuildContext context, FcmMessage fcmMessage) {
    if (fcmMessage.type == "IMAGE") {
      showItemDialog(context, fcmMessage);
    } else if (fcmMessage.type == "URL") {
      //set action here
    } else {}
  }

  //------------------------------------------------------------------------------
  void showItemDialog(BuildContext context, FcmMessage fcmMessage) {
    try {
      showDialog<bool>(
        context: context,
        builder: (_) => _buildDialog(context, fcmMessage),
      );
    } catch (e) {
      print(
          "================Error _showItemDialog message===========:\n ${e.toString()}");
    }
  }

  Widget _buildDialog(BuildContext context, FcmMessage fcmMessage) {
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: AlertDialog(
        content: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200]!,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /* Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                color: Colors.white,
                                child: Text(message_title,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppTheme.grey[700]!,
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w700,),),),
                          ),*/
                  fcmMessage.senderName == "" || fcmMessage.senderName == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Text(
                              fcmMessage.senderName ?? "",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        fcmMessage.body ?? "New Message",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                  fcmMessage.type != "IMAGE"
                      ? Container()
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: fcmMessage.image!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        fcmMessage.type != "URL"
                            ? Container()
                            : Container(
                                width: MediaQuery.of(context).size.width / 4.3,
                                child: FlatButton(
                                  color: Colors.grey,
                                  child: Text(
                                    "open",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                    /*Navigator.pushNamed(
                                  context, Routes.newUrlPages,arguments:fcmMessage.url);
                       */
                                  },
                                ),
                              ),
                        fcmMessage.type != "URL"
                            ? Container()
                            : SizedBox(
                                width: 2.0,
                              ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: FlatButton(
                            color: Colors.red,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[],
      ),
    );
  }
}
