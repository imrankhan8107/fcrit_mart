import 'dart:typed_data';

import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productname.dispose();
    _description.dispose();
    _mrp.dispose();
    _price.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.popAndPushNamed(context, '/sellerpage');
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                maxLines: 1,
                controller: _productname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  hintText: 'Product Name',
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            _image != null
                ? GestureDetector(
                    onTap: () async {
                      Uint8List img = await pickimage(ImageSource.gallery);
                      setState(() {
                        _image = img;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
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
                      Uint8List img = await pickimage(ImageSource.gallery);
                      setState(() {
                        _image = img;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/bluebackground.jpg'),
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
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: _mrp,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  hintText: 'Actual Price of Product',
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: _price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  hintText: 'Price Offered',
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                maxLines: 5,
                controller: _description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  hintText: 'Description',
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  if (FirebaseAuth.instance.currentUser?.isAnonymous != true &&
                      int.parse(_mrp.text) != 0 &&
                      int.parse(_price.text) != 0 &&
                      int.parse(_mrp.text) > int.parse(_price.text)) {
                    String photoUrl = await StorageMethods()
                        .uploadimgtofirebase(
                            'productImages', _image!, false, _productname.text);
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
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  child: const Center(child: Text('Upload')),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
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
