import 'dart:typed_data';

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

  //adding image to firebase storage
  Future<String> uploadimgtofirebase(
      String childname, Uint8List file, bool ispost) async {
    String res = "Error occurred while upload";
    try {
      Reference ref =
          _storage.ref().child(childname).child(_auth.currentUser!.uid);

      // UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snap = await ref.putData(file);
      String downloadurl = await snap.ref.getDownloadURL();
      res = 'success';
      print('res: $res');
      print('downloadurl: $downloadurl');
      return downloadurl;
    } catch (e) {
      print(e.toString());
      res = 'error occurred while upload';
    }
    return res;
  }
}
