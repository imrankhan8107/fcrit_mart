import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/list_of_items.dart';
import 'package:flutter/material.dart';

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
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
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
            allproducts,
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
