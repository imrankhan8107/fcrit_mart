import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

pickimage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  // print('No image selected');
}

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  Future<String> addImage({
    required int mrp,
    required int price,
    required String file,
    required String productName,
    required String description,
    required String uniqueId,
  }) async {
    DateTime currentTime = DateTime.now();
    String res = 'some error occured';

    DocumentReference allProductsDocRef =
        _firestore.collection('products').doc(uniqueId);
    // DocumentReference myProductsDocRef = _firestore
    //     .collection('users')
    //     .doc(_auth.currentUser!.uid)
    //     .collection('myProducts')
    //     .doc(uniqueId);
    try {
      if (file.isNotEmpty && productName.isNotEmpty && description.isNotEmpty) {
        await allProductsDocRef.set({
          'owner': _auth.currentUser?.uid,
          'checkedOut': false,
          'Name': productName.toLowerCase(),
          'file': file,
          'description': description,
          'publishTime': currentTime,
          'mrp': mrp,
          'search': setSearchParam(productName),
          'price': price,
          'id': uniqueId,
        });

        // await myProductsDocRef.set({
        //   'owner': _auth.currentUser?.uid,
        //   'checkedOut': false,
        //   'Name': productName.toLowerCase(),
        //   'file': file,
        //   'description': description,
        //   'publishTime': currentTime,
        //   'mrp': mrp,
        //   'price': price,
        //   'id': uniqueId,
        // });
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
      String childname, Uint8List file, bool ispost, String uniqueId) async {
    String res = "Error occurred while upload";
    try {
      Reference ref = _storage.ref().child(childname).child(uniqueId);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      String downloadurl = await snap.ref.getDownloadURL();
      String url = await ref.putData(file).snapshot.ref.getDownloadURL();
      res = 'success';
      Fluttertoast.showToast(msg: res);
      print('res: $res');
      print('downloadurl: $downloadurl');
      return url;
    } catch (e) {
      print(e.toString());
      res = 'error occurred while upload';
      print('res:$res');
    }
    Fluttertoast.showToast(msg: 'Image was not uploaded.');
    return 'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg';
  }
}
