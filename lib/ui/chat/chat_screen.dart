import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/constants/dimens.dart';
import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';
import 'package:flutterBoilerplateWithMobx/stores/chat/chat_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/widgets/handle_error_message_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/loading_animation.dart';
import 'package:flutterBoilerplateWithMobx/widgets/message_widgets.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  /// Chat TextField Controller.
  TextEditingController _msgController = TextEditingController();

  /// Initial Loading  Connects.
  bool _isLoading = true;
  bool _isSending = false;
  bool _isOnline = false;
  int imageQuality = 50;
  TextDirection textDirection = TextDirection.ltr;
  Timer? timer;
  int i = 1;
  String? myId;
  String? recipient_id;
  String? myName;
  String? appointmentId;
  String? otherName;
  bool? isSendFromDoctor;
  bool isLastEng = false;
  String _date = DateTime.now().toString();

  ThemeStore? themeStore;
  LanguageStore? languageStore;
  NavigationStore? navigationStore;
  late ChatStore chatStore;
  late UserStore _userStore;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    navigationStore = Provider.of<NavigationStore>(context);
    languageStore = Provider.of<LanguageStore>(context);
    themeStore = Provider.of<ThemeStore>(context);
    chatStore = Provider.of<ChatStore>(context);
    _userStore = Provider.of<UserStore>(context);
    if (!_userStore.loadingData) {
      _userStore.getUserData();
    }
    if (chatStore != null) {
      chatStore.resetListWidget("List");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Material(child: _buildBody()),
    );
  }

// body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Observer(builder: (context) {
      return Stack(
        children: <Widget>[
          HandleWarnMessage.internal().HandleErrorMessage(
            context: context,
            themeStore: themeStore!,
            title: chatStore.errorStore.errorTitle,
            errorMessage: chatStore.errorStore.errorMessage,
            isError: chatStore.errorStore.isError,
          ),
          _buildView(),
        ],
      );
    });
  }

  /// body methods:-------------------------------------------------------------
  Widget _buildView() {
    return Container(
      decoration: BoxDecorations.screensBoxDecoration(
          isDark: themeStore!.darkMode ? true : false),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Observer(builder: (context) {
              return chatStore.fetchListMessageFuture.value == null
                  ? Container()
                  : ListView.builder(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 1, bottom: 1),
                      reverse: true,
                      itemBuilder: (context, int index) => _buildChatMsg(
                          context,
                          index,
                          chatStore.fetchListMessageFuture.value!.length),
                      itemCount: chatStore.fetchListMessageFuture.value!.length,
                    );
            }),
          ),
          Divider(
            height: 4.0,
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 4.0,
              right: 4.0,
            ),
            child: chatInputWidget(context),
          ),
        ],
      ),
    );
  }

  ///---------------------------MESSAGE-WIDGET------------------------------------
  Widget _buildChatMsg(BuildContext context, int index, int itemCount) {
    chatStore.setMessageIndex(index);
    return InkWell(
      child: MessageWidget(
        themeStore: themeStore!,
        chatModel: chatStore.fetchListMessageFuture.value![index],
        isLastIndex: index == 0,
        locale: languageStore!.locale,
      ),
    );
  }

  ///---------------------------CHAT-INPUT-WIDGET---------------------------------
  Widget chatInputWidget(BuildContext context) {
    print(
        '===on detect successFetchMessage ${chatStore.successFetchMessage}===');

    if (chatStore.successFetchMessage) {
      print('=========== on receive successFetchMessage ================');

      if (chatStore.fetchMessageFuture.value != null) {
        String nums = chatStore.fetchMessageFuture.value!;
        List values = nums.split("||");

        /// split() will split from .and gives new List with separated elements.
        values.forEach(print);
        //chatStore.setFetchMessage(false);
        _sendMsg(
          context,
          msgContent: values[1].replaceAll("Answer:", "") ?? "",
          senderId: 4455,
          userId: _userStore.userModel.id,
          senderName: "ChatBot",
          createdAt: _date,
        );
      }
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, Dimens.screenHeight(context) / 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Column(
                children: <Widget>[
                  TextField(
                    textDirection: textDirection,
                    //focusNode: _focusNode,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    cursorColor: AppColors.mainColor[500],
                    keyboardType: TextInputType.multiline,
                    //onChanged: _onTypingCallBack,
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: "enter message",
                      labelText: "message",
                      fillColor: AppColors.mainColor[500],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            chatStore.loading
                ? Center(child: LoadingAnimation.stillLoading())
                : Material(
                    color: Colors.transparent,
                    child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          print("name ====== ${_userStore.userModel.name}");
                          _sendMsg(
                            context,
                            msgContent: _msgController.text,
                            senderId: _userStore.userModel.id,
                            userId: _userStore.userModel.id,
                            senderName: _userStore.userModel.name,
                            createdAt: _date,
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ));
  }

  ///-------------------------SEND FUNCTION ----------------------------------
  Future<void> _sendMsg(
    BuildContext context, {
    required String msgContent,
    required userId,
    required senderName,
    required senderId,
    required createdAt,
  }) async {
    await chatStore.insertMessage({
      GeneralConstants.msgContent: msgContent,
      GeneralConstants.senderName: senderName == "" ? "Me" : senderName,
      GeneralConstants.senderId: senderId,
      GeneralConstants.userId: userId,
      GeneralConstants.createdAt: createdAt
    });

    /// chatStore.getMessageFromRestApi(_msgController.text);
    _msgController.text = "";
  }

  @override
  void dispose() {
    timer?.cancel();
    chatStore.dispose();
    super.dispose();
  }
}
