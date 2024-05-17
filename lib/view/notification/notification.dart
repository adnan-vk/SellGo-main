import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/notification_controller/notification_controller.dart';
import 'package:authentication/model/authmodel.dart';
import 'package:authentication/model/notification_model.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/widgets/mediaquery_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationController>(context, listen: false)
        .filterAndGroupNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget().text(
          data: "Notifications",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            NavigatorHelper().pop(context: context);
          },
          icon: Icon(EneftyIcons.arrow_left_3_outline),
        ),
      ),
      body: Consumer<NotificationController>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.notificationsBySender.length,
            itemBuilder: (context, index) {
              String senderId =
                  value.notificationsBySender.keys.elementAt(index);
              List<NotificationModel> notifications =
                  value.notificationsBySender[senderId] ?? [];
              DateTime timestamp = notifications[0].timeStamp!;
              String formattedTime = DateFormat('hh:mm a').format(timestamp);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Card(
                  color: Color.fromARGB(255, 231, 241, 255),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                        color: Color.fromARGB(100, 180, 189, 196), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          // checkAndNavigate(context, notifications);
                        },
                        leading: CircleAvatar(
                          radius: MediaQueryWidget().width(context, .05),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          child: Icon(EneftyIcons.notification_outline),
                          // IconWidget(context,
                          //     iconData: IconlyLight.notification),
                        ),
                        title: TextWidget()
                            .text(data: notifications[0].title.toString()),
                        // CustomText(
                        //   text: notifications[0].title.toString(),
                        //   size: 13,
                        //   textAlign: TextAlign.start,
                        //   overflow: true,
                        // ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TextWidget().costumParagraphText(context,
                            //     text:
                            //         'You have received ${notifications.length} new message${notifications.length > 1 ? 's' : ''}',
                            //     trimLength: 40,
                            //     bold: false,
                            //     textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              right: MediaQueryWidget().width(context, .03),
                              bottom: MediaQueryWidget().width(context, .02)),
                          child: TextWidget().text(data: formattedTime)
                          // CustomText(
                          //     text: formattedTime,
                          //     size: 13,
                          //     bold: false,
                          //     textAlign: TextAlign.start),
                          )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  checkAndNavigate(context, List<NotificationModel> notifications) async {
    final getUserPrd =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final getNotificationPrd =
        Provider.of<NotificationController>(context, listen: false);
    if (notifications.isNotEmpty &&
        notifications[0].type == NotificationType.chat) {
      UserModel user = await getUserPrd.getUser();
      NavigatorHelper().push(context: context, page: ChatPage(userinfo: user));
      // NavigatorHelp().push(context, ChatPage(userinfo: user));
    }
    for (var id in notifications) {
      await getNotificationPrd.deleteNotification(context, id.id!);
    }
  }
}
