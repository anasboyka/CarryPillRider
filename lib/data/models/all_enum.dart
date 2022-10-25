enum StatusOrder {
  noOrder,
  orderReceived,
  findingDriver,
  driverFound,
  driverToHospital,
  driverQueue,
  orderPreparing,
  outForDelivery,
  orderArrived
}

enum ServiceType {
  requestDelivery,
  requestPickup,
  requestCart,
}

enum PaymentMethod {
  debitcredit,
  fpx,
  cash,
}
