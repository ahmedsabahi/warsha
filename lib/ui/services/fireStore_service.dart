import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warsha_app/ui/models/order.dart';
import '../models/service.dart';

class FireStoreService {
  User firebaseUser = FirebaseAuth.instance.currentUser;

  Stream<List<Order>> getOrders() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser.uid)
        .collection('Orders')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  Stream<List<Service>> getServices() {
    return FirebaseFirestore.instance.collection('services').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Service.fromJson(doc.data())).toList());
  }

  Future<void> deleteUser() {
    return FirebaseFirestore.instance
        .doc(firebaseUser.uid)
        .collection('Orders')
        .doc()
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateServices(String id, bool fav) {
    return FirebaseFirestore.instance
        .collection('services')
        .doc(id)
        .update({'isFavourite': fav})
        .then((value) => print("Service Updated"))
        .catchError((error) => print("Failed to update Service: $error"));
  }

  Future<void> deleteService(String serviceId) {
    return FirebaseFirestore.instance
        .collection('services')
        .doc(serviceId)
        .delete()
        .then((value) => print("Service Deleted"))
        .catchError((error) => print("Failed to delete service: $error"));
  }
}
