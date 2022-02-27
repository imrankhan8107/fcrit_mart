import 'dart:typed_data';

import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/image.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/user/seller_side/seller_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _productname = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _mrp = TextEditingController();
  final TextEditingController _price = TextEditingController();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    _selectimage(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Upload Image'),
            actions: [
              CupertinoDialogAction(
                child: Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List image = await pickimage(ImageSource.camera);
                  setState(() {
                    _image = image;
                  });
                },
              ),
              CupertinoDialogAction(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List image = await pickimage(ImageSource.gallery);
                  setState(() {
                    _image = image;
                  });
                },
              ),
              _image == null
                  ? const Divider(height: 0)
                  : CupertinoDialogAction(
                      child: const Text('Remove Image'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        setState(() {
                          _image = null;
                        });
                      },
                    ),
            ],
          );
        },
      );
    }

    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              title: const Text(
                'Add Details here',
                style: TextStyle(fontSize: 20),
              ),
              leading: Appbarbutton(
                ontapAppbar: () {
                  Navigator.popAndPushNamed(context, Sellerpage.id);
                },
              ),
            ),
            SizedBox(height: 15),
            Textfieldinput(
                textEditingController: _productname,
                hinttext: 'Product Name',
                textInputType: TextInputType.text,
                maxlines: 1),
            SizedBox(height: 5),
            _image != null
                ? GestureDetector(
                    onTap: () async {
                      _selectimage(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo),
                            Text('Add Image'),
                          ],
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      _selectimage(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo),
                            Text('Add Image'),
                          ],
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 5),
            Textfieldinput(
                textEditingController: _mrp,
                hinttext: 'Actual Price of Product',
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxlines: 1),
            Textfieldinput(
                textEditingController: _price,
                hinttext: 'Price Offered',
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxlines: 1),
            Textfieldinput(
                textEditingController: _description,
                hinttext: 'Description',
                textInputType: TextInputType.text,
                maxlines: 4),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  var uuid = const Uuid();
                  String productId = uuid.v4();
                  if (FirebaseAuth.instance.currentUser?.isAnonymous != true &&
                      int.parse(_mrp.text) != 0 &&
                      int.parse(_price.text) != 0 &&
                      int.parse(_mrp.text) > int.parse(_price.text)) {
                    String photoUrl = await StorageMethods()
                        .uploadimgtofirebase(
                            'productImages', _image!, false, productId);
                    String imgres = await StorageMethods().addImage(
                      mrp: int.parse(_mrp.text, onError: (String value) {
                        value = '';
                        return 0;
                      }),
                      price: int.parse(_price.text, onError: (String value) {
                        value = '';
                        return 0;
                      }),
                      file: photoUrl,
                      productName: _productname.text,
                      description: _description.text,
                      uniqueId: productId,
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('Item Uploaded Successfully'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Return to HomePage'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _productname.dispose();
                                _description.dispose();
                                _mrp.dispose();
                                _price.dispose();
                                Navigator.popAndPushNamed(
                                    context, Sellerpage.id);
                              },
                            )
                          ],
                        );
                      },
                    );

                    print(imgres);
                    print(photoUrl);
                  } else if (FirebaseAuth.instance.currentUser?.isAnonymous ==
                          true &&
                      int.parse(_mrp.text) != 0 &&
                      int.parse(_price.text) != 0 &&
                      int.parse(_mrp.text) > int.parse(_price.text)) {
                    Fluttertoast.showToast(msg: 'Please Sign in First');
                  } else if (FirebaseAuth.instance.currentUser?.isAnonymous !=
                          true &&
                      int.parse(_mrp.text) == 0 &&
                      int.parse(_price.text) != 0 &&
                      int.parse(_mrp.text) > int.parse(_price.text)) {
                    Fluttertoast.showToast(
                        msg: 'Please Enter the MRP of product');
                  } else if (FirebaseAuth.instance.currentUser?.isAnonymous !=
                          true &&
                      int.parse(_mrp.text) != 0 &&
                      int.parse(_price.text) == 0 &&
                      int.parse(_mrp.text) > int.parse(_price.text)) {
                    Fluttertoast.showToast(
                        msg:
                            'Please Enter the price you are offering for product');
                  } else if (FirebaseAuth.instance.currentUser?.isAnonymous !=
                          true &&
                      int.parse(_mrp.text) != 0 &&
                      int.parse(_price.text) != 0 &&
                      int.parse(_mrp.text) < int.parse(_price.text)) {
                    Fluttertoast.showToast(
                        msg: 'Price offered cannot be greater than MRP');
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Some error occurred from your end');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                  print(e.toString());
                }
                // Navigator.pushReplacementNamed(context, Sellerpage.id);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  child: const Center(
                      child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: kGradientcolor,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
