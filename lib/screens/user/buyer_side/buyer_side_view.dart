import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyersideHomepage extends StatelessWidget {
  const BuyersideHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(FontAwesomeIcons.productHunt),
                text: 'All products',
              ),
              Tab(
                text: 'Search',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const AllProductDetails(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
