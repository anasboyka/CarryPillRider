import 'package:carrypill_rider/constant/constant_string.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<String>> fetchSignInMethodForEmail(String email) async {
    return await _auth.fetchSignInMethodsForEmail(email);
  }

  Future<dynamic> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return ksErrorEmailAlreadyUsed;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return ksErrorWrongPassword;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return ksErrorUserNotFound;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return ksErrorUserDisabled;
        case "ERROR_TOO_MANY_REQUESTS":
          return ksErrorToManyRequest;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return ksErrorOperationNotAllowed;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return ksErrorInvalidEmail;
        default:
          return "Register failed. Please try again.";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests to log into this account.";
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";
        default:
          print(e.code);
          print(e.message);
          print(e.stackTrace);
          print(e);

          return "Register failed. Please try again.";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  RiderAuth? _riderFromFirebase(User? user) {
    return RiderAuth(
        uid: user!.uid, displayName: user.displayName, email: user.email);
  }

  Stream<RiderAuth?> get rider {
    return _auth.authStateChanges().map(_riderFromFirebase);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
