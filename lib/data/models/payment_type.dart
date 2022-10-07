import 'package:carrypill_rider/data/models/all_enum.dart';

class PaymentType {
  String imgPath;
  String paymentName;
  PaymentMethod paymentMethod;

  PaymentType(
      {required this.imgPath,
      required this.paymentName,
      required this.paymentMethod});
}
