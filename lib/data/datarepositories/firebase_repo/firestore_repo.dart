import 'package:carrypill_rider/constant/constant_string.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/clinic.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/profile.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepo {
  final String? uid;

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patients');

  final CollectionReference followUpClinicCollection =
      FirebaseFirestore.instance.collection('followupclinics');

  final CollectionReference facilityCollection =
      FirebaseFirestore.instance.collection('healthcare_facilities');

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference riderCollection =
      FirebaseFirestore.instance.collection('riders');

  FirestoreRepo({this.uid});

  Stream<Rider?> get rider {
    return riderCollection
        .doc(uid)
        .snapshots()
        .map((doc) => Rider.fromFirestore(doc));
  }

  Future createRider(Rider rider) async {
    return await riderCollection.doc(uid).set(rider.toMap());
  }

  Future updateRiderInfoOverwrite(Rider rider) async {
    return await riderCollection.doc(uid).set(rider.toMap());
  }

  Future updateRiderProfileInfo(Profile? profile) async {
    return await riderCollection.doc(uid).update({'profile': profile?.toMap()});
  }

  Future updateRiderVehicleInfo(Vehicle? vehicle) async {
    return await riderCollection.doc(uid).update({'vehicle': vehicle?.toMap()});
  }

  Future updateCurrentOrderId(String? orderId) async {
    return await riderCollection.doc(uid).update({'currentOrderId': orderId});
  }

  Future updateAutoAccept(bool autoAccept) async {
    return await riderCollection.doc(uid).update({'autoAccept': autoAccept});
  }

  Future updateWorkingStatus(bool? isWorking, String? workingStatus) async {
    Map<String, dynamic> data = {};
    if (isWorking != null) {
      data.addAll({"isWorking": isWorking});
    }
    if (workingStatus != null) {
      data.addAll({"workingStatus": workingStatus});
    }
    return await riderCollection.doc(uid).update(data);
  }

  Future updateRiderInfo(
      {String? firstName,
      String? lastName,
      String? phoneNum,
      String? vehicleType}) async {
    Map<String, dynamic> data = {};
    if (firstName != null) {
      data.addAll({"firstName": firstName});
    }
    if (lastName != null) {
      data.addAll({"lastName": lastName});
    }
    if (phoneNum != null) {
      data.addAll({"phoneNum": phoneNum});
    }
    if (vehicleType != null) {
      data.addAll({"vehicleType": vehicleType});
    }
    if (data.isEmpty) {
      return null;
    } else {
      return await riderCollection.doc(uid).update(data);
    }
  }

  // Future addRider(Rider rider) async {
  //   return await riderCollection.add(rider.toMap());
  // }

  Stream<bool> isProfileCompleteStream() {
    return riderCollection.doc(uid).snapshots().map((doc) {
      return (doc.data() as Map)[ksIsProfileCompleteRider];
    });
  }

  Future<bool> isProfileCompleteFuture() async {
    return riderCollection.doc(uid).get().then((doc) {
      return (doc.data() as Map)[ksIsProfileCompleteRider];
    });
  }

  Future<bool> isRiderExist() async {
    return riderCollection.doc(uid).get().then((doc) {
      return doc.exists;
    });
  }

  Future<dynamic> addFollowUpClinic(
      CollectionReference colref, Clinic clinic) async {
    return await colref.add(clinic.toMap());
  }

  //up order
  //  Future addOrder(OrderService orderService) async {
  //   return await orderCollection.add(orderService.toMap());
  // }

  Future updateStatusOrder(StatusOrder statusOrder, String id) async {
    return await orderCollection.doc(id).update({
      'statusOrder': statusOrder.name,
    });
  }

  Future updateOrderComplete(
      String orderId, DateTime dateTimeComplete, bool isWorking) async {
    await orderCollection.doc(orderId).update({
      'orderQueryStatus': 'orderArrived',
      'statusOrder': StatusOrder.orderArrived.name,
      'orderDateComplete': dateTimeComplete,
    });
    await riderCollection.doc(uid).update({
      'currentOrderId': null,
      'workingStatus': isWorking ? 'isWaitingForOrder' : 'stopAcceptingOrder',
    });
  }

  Future updateOrderQueryStatus(String orderQueryStatus, String orderId) async {
    return await orderCollection.doc(orderId).update({
      'orderQueryStatus': orderQueryStatus,
    });
  }

  Future updateOrderQueryStatusPendingTransaction(String orderId) async {
    final db = FirebaseFirestore.instance;
    db.runTransaction((transaction) async {
      final snapshot = await transaction.get(orderCollection.doc(orderId));
      if (snapshot.get('orderQueryStatus') == 'findingRider') {
        transaction.update(orderCollection.doc(orderId), {
          'orderQueryStatus': 'Pending',
        });
      }
    });
  }

  Future updateOrderAccepted(String orderId) async {
    await orderCollection.doc(orderId).update({
      'orderQueryStatus': 'orderAccepted',
      'riderRef': uid,
      'statusOrder': StatusOrder.driverFound.name,
    });
    await riderCollection.doc(uid).update({'workingStatus': 'acceptedOrder'});
  }

  Future updateOrderAcceptedTransaction(String orderId) async {
    final db = FirebaseFirestore.instance;
    db.runTransaction((transaction) async {
      final snapshot = await transaction.get(orderCollection.doc(orderId));
      if (snapshot.get('orderQueryStatus') == 'findingRider') {
        transaction.update(orderCollection.doc(orderId), {
          'orderQueryStatus': 'orderAccepted',
          'riderRef': uid,
          'statusOrder': StatusOrder.driverFound.name,
        });
      }
    });

    // return await orderCollection.doc(orderId).update({
    //   'orderQueryStatus': 'orderAccepted',
    //   'riderRef': uid,
    //   'statusOrder': StatusOrder.driverFound.name,
    // });
  }

  // Future updateOrderRejected(List<String> ridersId, String orderId) async {
  //   return await orderCollection.doc(orderId).update({
  //     'orderQueryStatus': 'findingDriver',
  //     'riderCancelId': FieldValue.arrayUnion(ridersId),
  //   });
  // }

  Future updateOrderRejected(List<String> ordersId) async {
    await riderCollection.doc(uid).update({
      'orderCancelId': FieldValue.arrayUnion(ordersId),
      'workingStatus': 'isWaitingForOrder',
      'currentOrderId': null,
    });
    print(ordersId[0]);
    await orderCollection.doc(ordersId[0]).update({
      'riderPending': false,
    });
  }

  // Future updateRiderCancel(List<String> ridersId, String orderId) async {
  //   return await orderCollection.doc(orderId).update({
  //     'riderCancelId': FieldValue.arrayUnion(ridersId),
  //   });
  // }

  // Future updateOrderDateComplete(DateTime dateTime, String id) async {
  //   return await orderCollection.doc(id).update({
  //     'orderDateComplete': dateTime,
  //   });
  // }

  // Future getOrderService() async {
  //   return await orderCollection
  //       .where('patientRef', isEqualTo: uid)
  //       .orderBy('orderDate', descending: true)
  //       .limit(1)
  //       .get()
  //       .then((data) => OrderService.fromFirestore(data.docs.first));
  // }

  // Stream<OrderService> streamCurrentOrder({bool descending = true}) {
  //   var snap = orderCollection
  //       .where('riderRef', isEqualTo: uid)
  //       .orderBy('orderDate', descending: descending)
  //       .limit(1)
  //       .snapshots();

  //   return snap.map((event) => OrderService.fromFirestore(event.docs.first));
  // }

  Stream<OrderService> streamCurrentOrder(String orderId,
      {bool descending = true}) {
    var snap = orderCollection.doc(orderId).snapshots();
    return snap.map((event) => OrderService.fromFirestore(event));
  }

  Future<OrderService> getCurrentOrder(String orderId) async {
    return orderCollection
        .doc(orderId)
        .get()
        .then((value) => OrderService.fromFirestore(value));
  }

  Stream<List<OrderService>> streamListOrder({bool descending = true}) {
    return orderCollection
        .where('patientRef', isEqualTo: uid)
        .orderBy('orderDate', descending: descending)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<OrderService>> streamListOrderAvailable(
      {bool descending = true}) {
    List<String> uidList = [uid!];
    return orderCollection
        .where('orderQueryStatus', isEqualTo: 'findingDriver')
        // .where('riderCancelId', whereNotIn: uidList)
        // .orderBy('riderCancelId')
        .orderBy('orderDate', descending: descending)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  List<OrderService> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => OrderService.fromFirestore(doc)).toList();
  }

  //down order
}
