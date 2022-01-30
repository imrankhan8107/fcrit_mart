import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // await FirebaseAuth.instance.signInWithCredential(FacebookAuthProvider.credential(accesstoken))
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

  Future<String> addImage({
    required String file,
    required String productName,
    required String description,
  }) async {
    String res = 'some error occured';
    try {
      if (file.isNotEmpty && productName.isNotEmpty && description.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .collection('products')
            .doc(_auth.currentUser?.uid)
            .set({
          'Name': productName,
          'file': file,
          'description': description,
        });
        res = 'success';
      }
      return res;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //signup the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required int mobileno,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          mobileno.toString().length == 10) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user?.uid);
        // _auth.currentUser?.sendEmailVerification();
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
        res = 'Sign up Successful';
      } else if (email.isEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          mobileno.toString().length == 10) {
        res = "Please enter your email";
      } else if (email.isNotEmpty &&
          password.isEmpty &&
          name.isNotEmpty &&
          mobileno.toString().length == 10) {
        res = "Please enter your password";
      } else if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isEmpty &&
          mobileno.toString().length == 10) {
        res = "Please enter your name";
      } else if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          mobileno.toString().length != 10) {
        res = "Please enter valid mobile number";
      } else if (email.isEmpty ||
          password.isEmpty ||
          name.isEmpty ||
          mobileno.toString().length != 10) {
        res = "Please enter all the credentials";
      } else {
        res = 'Something went wrong';
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          res = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          res = "Your password is wrong.";
          break;
        case "user-not-found":
          res = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          res = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          res = "Too many requests";
          break;
        case "operation-not-allowed":
          res = "Signing in with Email and Password is not enabled.";
          break;
        default:
          res = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: res);
      print(e.code);
    }
    Fluttertoast.showToast(msg: res);
    return res;
  }
}
