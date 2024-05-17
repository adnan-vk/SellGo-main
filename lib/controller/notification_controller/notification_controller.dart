import 'package:authentication/model/notification_model.dart';
import 'package:authentication/service/notification/notification_service.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  NotificationService fireStoreService = NotificationService();
  final user = FirebaseAuth.instance.currentUser;
  List<NotificationModel> allNotification = [];
  DateTime? latestNotificationTime;
  Map<String, List<NotificationModel>> notificationsBySender = {};

  sendNotification({String? content, String? title, String? receiverId}) async {
    final data = NotificationModel(
        content: content,
        id: user!.uid + DateTime.now().toString(),
        receiverId: receiverId,
        senderId: user!.uid,
        type: NotificationType.chat,
        timeStamp: DateTime.now(),
        title: title);
    return await fireStoreService.sendNotification(data);
  }

  deleteNotification(context, String id) async {
    await fireStoreService.deleteNotification(id);
    filterAndGroupNotifications(context);
    // notifyListeners();
  }

  getNotifications(BuildContext context) async {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        await fireStoreService.getNotifications();
    snapshot.listen((message) {
      final newNotifications = message.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();

      if (newNotifications.isNotEmpty) {
        final latestTime = newNotifications[0].timeStamp;
        if (latestNotificationTime == null ||
            latestTime!.isAfter(latestNotificationTime!)) {
          latestNotificationTime = latestTime;
          snackBarWidget().iconSnackSuccess(context, label: "notofication");
          // PopUpWidgets().showDelightToastBarNotification(context,
          //     title: newNotifications[0].title!, toastItem: ToastItem.success);
        }
      }

      allNotification.clear();
      allNotification.addAll(newNotifications);
      notifyListeners();
    });
  }

  filterAndGroupNotifications(BuildContext context) {
    getNotifications(context);
    notificationsBySender.clear();
    for (var notification in allNotification) {
      String senderId = notification.senderId ?? '';
      if (!notificationsBySender.containsKey(senderId)) {
        notificationsBySender[senderId] = [];
      }
      notificationsBySender[senderId]!.add(notification);
    }
    // notifyListeners();
  }
}
