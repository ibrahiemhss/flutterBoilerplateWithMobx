import 'package:flutter/material.dart';
import 'package:flutterBoilerplateWithMobx/models/message/message_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class MessageWidget extends StatelessWidget {
  final MessageModel chatModel;
  final String locale;
  final selectorOnTap;
  final bool isLastIndex;
  final ThemeStore themeStore;
  const MessageWidget(
      {required this.chatModel,
      required this.locale,
      required this.isLastIndex,
      required this.themeStore,
      this.selectorOnTap});

  bool get _isMe =>
      chatModel.senderId.toString() == chatModel.userId.toString();

  BorderRadius get _myBorder {
    return locale == 'ar'
        ? BorderRadius.only(
            topRight: const Radius.circular(2.0),
            topLeft: const Radius.circular(12.0),
            bottomRight: const Radius.circular(12.0),
            bottomLeft: const Radius.circular(12.0),
          )
        : BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(12.0),
            bottomRight: const Radius.circular(12.0),
            bottomLeft: const Radius.circular(12.0),
          );
  }

  BorderRadius get _otherBorder {
    return locale == 'ar'
        ? BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(12.0),
            bottomRight: const Radius.circular(12.0),
            bottomLeft: const Radius.circular(12.0),
          )
        : BorderRadius.only(
            topRight: const Radius.circular(2.0),
            topLeft: const Radius.circular(12.0),
            bottomRight: const Radius.circular(12.0),
            bottomLeft: const Radius.circular(12.0),
          );
  }

  Widget _senderName(BuildContext context) {
    return Text(
      "${chatModel.senderName}",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _sentTimeWidget(BuildContext context) {
    return Text(
      "${_timeAgoSinceDate(chatModel.sendTime)}",
      style: Theme.of(context).textTheme.overline,
    );
  }

  Widget get _textWidget {
    return Builder(
      builder: (context) {
        return InkWell(
            onTap: selectorOnTap,
            child: Container(
              padding: const EdgeInsets.only(
                // bottom: 2.0,
                // top: 2.0,
                right: 8.0,
                left: 8.0,
              ),
              decoration: BoxDecoration(
                color: themeStore.darkMode ? Colors.cyan[900] : Colors.cyan[50],
                borderRadius: _isMe ? _myBorder : _otherBorder,
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              child: Text(
                chatModel.msgContent,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ));
      },
    );
  }

  Widget _msgBox(BuildContext context) {
    return Opacity(opacity: 0.6, child: _textWidget);
  }

  @override
  Widget build(BuildContext context) {
    double _container_img_height;
    double _container_img_width;
    final mediaQueryData = MediaQuery.of(context);

    if (mediaQueryData.orientation == Orientation.landscape) {
      _container_img_height = MediaQuery.of(context).size.height / 0.4;
      _container_img_width = MediaQuery.of(context).size.width / 0.4;
    } else {
      _container_img_height = MediaQuery.of(context).size.width / 0.4;
      _container_img_width = MediaQuery.of(context).size.height / 0.4;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment:
            _isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // if (_isMe) ...[_profilePic],
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                  _isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                _senderName(context),
                _isMe
                    ? Row(
                        children: <Widget>[
                          _msgBox(context),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          _msgBox(context),
                        ],
                      ),
                _sentTimeWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    // if (locale == 'ar') {
    timeAgo.setLocaleMessages(locale, timeAgo.ArMessages());
    return timeAgo.format(date, locale: locale);
  }
}
