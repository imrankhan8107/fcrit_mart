import 'package:cloud_firestore/cloud_firestore.dart';
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

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String mobileno,
    // required Uint8List file,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          mobileno.isNotEmpty) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user?.uid);

        //adding user to database
        await _firestore.collection('users').doc(cred.user?.uid).set({
          'name': name,
          'uid': cred.user?.uid,
          'email': email,
          'mobileNo': mobileno,
        });
        //set method is only on the document above
        //using the set method we get the same uid everywhere.so in case if we want to access through uid then set method is prefarable
        //another way of doing this above database stuff
        //add method is on the collection as shown below
        //if we use add method then our uid is different bcoz uid is set randomly by firebase. but we dont have to worry bcoz everytime uid is created, it is different for different users

        // _firestore.collection('users').add({
        //   'name': name,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'mobileNo': mobileno,
        // });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
