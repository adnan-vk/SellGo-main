import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/notification_controller/notification_controller.dart';
import 'package:authentication/model/authmodel.dart';
import 'package:authentication/model/notification_model.dart';
import 'package:authentication/view/details/chatpage/chat.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/mediaquery_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        leading: ButtonWidget().leadingIcon(context),
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
                child: Slidable(
                  key: ValueKey(senderId),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          value.deleteNotification(context, senderId);
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    color: Color.fromARGB(255, 231, 241, 255),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                          color: Color.fromARGB(100, 180, 189, 196),
                          width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          hoverColor: Colors.transparent,
                          onTap: () {
                            checkAndNavigate(context, notifications);
                          },
                          leading: CircleAvatar(
                            radius: MediaQueryWidget().width(context, .05),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            child: Icon(EneftyIcons.notification_outline),
                          ),
                          title: TextWidget().text(
                            data: notifications[0].title.toString(),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQueryWidget().width(context, .03),
                            bottom: MediaQueryWidget().width(context, .02),
                          ),
                          child: TextWidget().text(data: formattedTime),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void checkAndNavigate(context, List<NotificationModel> notifications) async {
    final getUserPrd =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final getNotificationPrd =
        Provider.of<NotificationController>(context, listen: false);
    if (notifications.isNotEmpty &&
        notifications[0].type == NotificationType.chat) {
      UserModel user = await getUserPrd.getUser();
      NavigatorHelper().push(
        context: context,
        page: ChatPage(userinfo: user),
      );
    }
    for (var id in notifications) {
      await getNotificationPrd.deleteNotification(context, id.id!);
    }
  }
}
