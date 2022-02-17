import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/list_of_items.dart';
import 'package:flutter/material.dart';

class Myproducts extends StatelessWidget {
  const Myproducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Appbarbutton(
            ontapAppbar: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Seller page',
            style: TextStyle(fontSize: 18),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'All products',
              ),
              Tab(
                text: 'My Items',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            allproducts,
            myproducts,
          ],
        ),
      ),
    );
  }
}

class CardswithDetails extends StatelessWidget {
  const CardswithDetails(
      {Key? key,
      required this.color,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          style: ListTileStyle.list,
          leading: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            color: color,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          // trailing: Icon(Icons.more_vert),
          isThreeLine: true,
        ),
      ),
    );
  }
}
