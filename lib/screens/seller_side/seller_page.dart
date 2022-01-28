import 'dart:typed_data';

import 'package:fcrit_mart/components/image.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:fcrit_mart/screens/seller_side/my_products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);

  @override
  State<Sellerpage> createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  Uint8List? _image;
  int _selectedIndex = 0;
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final TextEditingController _productname = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const Myproducts(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                      height: 200,
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
          const SizedBox(
            height: 30,
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
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              try {
                String photoUrl = await StorageMethods()
                    .uploadimgtofirebase('productImages', _image!, false);
                String imgres = await Authmethods().addImage(
                    file: photoUrl,
                    productName: _productname.text,
                    description: _description.text);
                print(imgres);
                print(photoUrl);
              } catch (e) {
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
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const AppDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        // 6
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
