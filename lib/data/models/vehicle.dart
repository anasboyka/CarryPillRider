import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String? vehiclePlateNum;
  final String? vehicleRoadTaxImageUrl;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Vehicle({
    this.vehiclePlateNum,
    this.vehicleRoadTaxImageUrl,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return Vehicle(
      vehiclePlateNum: map['vehiclePlateNum'],
      vehicleRoadTaxImageUrl: map['vehicleRoadTaxImageUrl'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehiclePlateNum: map['vehiclePlateNum'],
      vehicleRoadTaxImageUrl: map['vehicleRoadTaxImageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
        'vehiclePlateNum': vehiclePlateNum,
        'vehicleRoadTaxImageUrl': vehicleRoadTaxImageUrl,
      };

  @override
  String toString() {
    return '${vehiclePlateNum.toString()}, ${vehicleRoadTaxImageUrl.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Vehicle && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
