import 'dart:typed_data';

import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/image.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/screens/seller_side/seller_page.dart';
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
                  Navigator.popAndPushNamed(context, Sellerpage.id);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Textfieldinput(
                textEditingController: _productname,
                hinttext: 'Product Name',
                textInputType: TextInputType.text,
                maxlines: 1),
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
                maxlines: 5),
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
                        .uploadimgtofirebase('productImages', _image!, false);
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
