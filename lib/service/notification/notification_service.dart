import 'package:authentication/model/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String collection = 'User';
  sendNotification(NotificationModel data) async {
    try {
      await firestore
          .collection(collection)
          .doc(data.receiverId)
          .collection('notification')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      throw 'Error in send notification : $e';
    }
  }

  getNotifications() async {
    try {
      final snapshots = await firestore
          .collection(collection)
          .doc(firebaseAuth.currentUser!.uid)
          .collection('notification')
          .orderBy('timeStamp', descending: true)
          .snapshots();
      return snapshots;
    } catch (e) {
      throw 'Error in get Notification Data: $e';
    }
  }

  deleteNotification(String id) async {
    try {
      await firestore
          .collection(collection)
          .doc(firebaseAuth.currentUser!.uid)
          .collection('notification')
          .doc(id)
          .delete();
      // log('message');
    } catch (e) {
      throw e;
    }
  }
}
