import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/clinic.dart';
import 'package:carrypill_rider/data/models/facility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderService {
  //List<Clinic> clinicList;
  Facility? facility;
  StatusOrder statusOrder;
  ServiceType? serviceType;
  PaymentMethod? paymentMethod;
  double totalPay;

  //DateTime? appointment;
  DateTime? orderDate;
  DateTime? orderComplete;
  String? patientRef;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  OrderService({
    //required this.clinicList,
    this.statusOrder = StatusOrder.noOrder,
    this.serviceType,
    this.paymentMethod,
    this.totalPay = 0,
    //this.appointment,
    this.orderDate,
    this.orderComplete,
    this.patientRef,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory OrderService.fromFirestore(DocumentSnapshot snapshot) {
// if(snapshot == null) return null;
    dynamic map = snapshot.data();

    return OrderService(
      // clinicList:
      //     map['clinicList'] != null ? List<Clinic>.from(map['clinicList']) : [],
      statusOrder: map['statusOrder'] != null
          ? StatusOrder.values.byName(map['statusOrder'])
          : StatusOrder.noOrder,
      serviceType: map['serviceType'] != null
          ? ServiceType.values.byName(map['serviceType'])
          : null,
      paymentMethod: map['paymentType'] != null
          ? PaymentMethod.values.byName(map['paymentType'])
          : null,
      totalPay: map['totalPay'],
      orderDate: map['orderDate']?.toDate(),
      orderComplete: map['orderComplete']?.toDate(),
      patientRef: map['patientRef'],
      // appointment: map['appointment']?.toDate(),
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory OrderService.fromMap(Map<String, dynamic> map) {
    return OrderService(
      // clinicList: map['clinicList'] != null
      //     ? map['clinicList']
      //         .map<Clinic>((mapString) => Clinic.fromMap(mapString))
      //         .toList()
      //     : [],
      statusOrder: map['statusOrder'] != null
          ? StatusOrder.values.byName(map['statusOrder'])
          : StatusOrder.noOrder,
      serviceType: map['serviceType'] != null
          ? ServiceType.values.byName(map['serviceType'])
          : null,
      paymentMethod: map['paymentMethod'] != null
          ? PaymentMethod.values.byName(map['paymentMethod'])
          : null,
      totalPay: map['totalPay'],
      orderDate: (map['orderDate']?.toDate()),
      orderComplete: map['orderComplete']?.toDate(),
      patientRef: map['patientRef'],
      // appointment: map['appointment']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        // 'clinicList': clinicList.map((e) => e.toMap()).toList(),
        'statusOrder': statusOrder.name,
        'serviceType': serviceType?.name,
        'paymentMethod': paymentMethod?.name,
        'totalPay': totalPay,
        'orderDate': orderDate,
        'orderComplete': orderComplete,
        'patientRef': patientRef
        // 'appointment': appointment,
      };

  OrderService copyWith({
    required final List<Clinic> clinicList,
    final StatusOrder? statusOrder,
    final ServiceType? serviceType,
    final PaymentMethod? paymentMethod,
    final double? totalPay,
    final DateTime? orderDate,
    final DateTime? orderComplete,
    final DateTime? appointment,
    final String? patientRef,
  }) {
    return OrderService(
      // clinicList: clinicList,
      statusOrder: statusOrder ?? this.statusOrder,
      serviceType: serviceType ?? this.serviceType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPay: totalPay ?? this.totalPay,
      orderDate: orderDate ?? this.orderDate,
      orderComplete: orderComplete ?? this.orderComplete,
      patientRef: patientRef ?? this.patientRef,
      // appointment: appointment ?? this.appointment,
    );
  }

  @override
  String toString() {
    return '{clinicList.toString()}, ${statusOrder.toString()}, ${orderDate.toString()}, ${orderComplete.toString()},${totalPay.toString()},${paymentMethod.toString()},${orderDate.toString()},${serviceType.toString()},${patientRef.toString()} ';
  }

  @override
  bool operator ==(other) =>
      other is OrderService && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
