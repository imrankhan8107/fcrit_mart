import 'package:fcrit_mart/screens/user/buyer_side/search_page.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/appbar_button.dart';

class BuyersideHomepage extends StatelessWidget {
  BuyersideHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List searchListResult = [];
    //TODO:SEARCH PAGE
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buyer view',
          style: TextStyle(fontSize: 18),
        ),
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(FontAwesomeIcons.search)),
        ],
      ),
      body: AllProductDetails(),
    );
  }
}
