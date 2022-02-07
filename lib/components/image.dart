import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

pickimage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addImage({
    required int mrp,
    required int price,
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
            .doc()
            .set({
          'Name': productName,
          'file': file,
          'description': description,
          'mrp': mrp,
          'price': price,
        });
        res = 'success';
      }
      return res;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //adding image to firebase storage
  Future<String> uploadimgtofirebase(
      String childname, Uint8List file, bool ispost, String productname) async {
    String res = "Error occurred while upload";
    try {
      Reference ref = _storage
          .ref()
          .child(childname)
          .child(_firestore.collection(productname).id);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      String downloadurl = await snap.ref.getDownloadURL();
      String url = await ref.putData(file).snapshot.ref.getDownloadURL();
      res = 'success';
      print('res: $res');
      print('downloadurl: $downloadurl');
      return url;
    } catch (e) {
      print(e.toString());
      res = 'error occurred while upload';
      print('res:$res');
    }
    return 'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg';
  }
}
