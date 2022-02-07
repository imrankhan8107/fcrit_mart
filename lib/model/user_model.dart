import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String uid;
  final String email;
  final int mobileno;

  User({
    required this.email,
    required this.uid,
    required this.mobileno,
    required this.name,
  });

  Map<String, dynamic> toJson() =>
      {'username': name, 'uid': uid, 'email': email, 'mobileno': mobileno};

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      mobileno: snapshot['mobileno'],
    );
  }
}
