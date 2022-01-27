import 'dart:typed_data';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/image.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);

  @override
  State<Sellerpage> createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static final List<Widget> _widgetOptions = <Widget>[
      Column(
        children: const [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Item 1'),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Item 1'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Item 1'),
          ),
        ],
      ),
      Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Uint8List img = await pickimage(ImageSource.gallery);
              setState(() {
                _image = img;
              });
            },
            child: Row(
              children: const [
                Icon(Icons.add_a_photo),
                Text('Add Image'),
              ],
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Description',
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ],
      ),
      const Text(
        'Index 2: Settings',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Hello Seller'),
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
