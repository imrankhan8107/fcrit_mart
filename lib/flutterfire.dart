import 'package:firebase_auth/firebase_auth.dart';

Future<String> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'Yes';
  } catch (e) {
    print(e);
    return 'No';
  }
}

Future<String> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return 'Yes';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('the password provided is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('the Account already exist for that email');
    }
    return 'No';
  } catch (e) {
    print(e.toString());
    return 'No';
  }
}
