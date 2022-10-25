//model attribute clinic
const ksClinicNameClinic = 'clinicName';
const ksStatusClinic = 'status';

//model facility
const ksFacilityNameFacility = 'facilityName';
const ksGeopointFacility = 'geoPoint';

//model order_service
const ksStatusOrderOrderService = 'statusOrder';
const ksServiceTypeOrderService = 'serviceType';
const ksPaymentMethodOrderService = 'paymentMethod';
const ksTotalPayOrderService = 'totalPay';
const ksOrderDateOrderService = 'orderDate';
const ksOrderDateCompleteOrderService = 'orderDateComplete';
const ksPatientRefOrderService = 'patientRef';

//model patient
const ksNamePatient = 'name';
const ksIcNumPatient = 'icNum';
const ksPhoneNumPatient = 'phoneNum';
const ksPatientIdPatient = 'patientId';
const ksAddressPatient = 'address';
const ksClinicListPatient = 'clinicList';
const ksAppointmentPatient = 'appointment';
const ksGeoPointPatient = 'geoPoint';

//rider
const ksFirstNameRider = 'firstName';
const ksLastNameRider = 'lastName';
const ksPhoneNumRider = 'phoneNum';
const ksVehicleTypeRider = 'vehicleType';
const ksWorkingStatusRider = 'workingStatus';
const ksIsWorkingRider = 'isWorking';
const ksCurrentLocationRider = 'currrentLocation';
const ksIsProfileCompleteRider = 'isProfileComplete';

//variable status constant
const ksStopAcceptingOrder = 'stopAcceptingOrder';
const ksIsWaitingForOrder = 'isWaitingForOrder';
const ksIsPendingOrder = 'isPendingOrder';
const ksDeliveringOrder = 'deliveringOrder';

//error constant
const ksErrorEmailAlreadyUsed = "Email already used";
const ksErrorWrongPassword = "Wrong password";
const ksErrorUserNotFound = "No user found with this email.";
const ksErrorUserDisabled = "User disabled.";
const ksErrorToManyRequest = "Too many requests to log into this account.";
const ksErrorOperationNotAllowed = "Server error, please try again later.";
const ksErrorInvalidEmail = "Email address is invalid.";
