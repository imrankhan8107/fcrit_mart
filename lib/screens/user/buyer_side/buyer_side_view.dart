import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:flutter/material.dart';

class BuyersideHomepage extends StatelessWidget {
  BuyersideHomepage({Key? key}) : super(key: key);
  final TextEditingController searchBox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List searchListResult = [];
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
            AllProductDetails(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchBox,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context),
                      ),
                    ),
                  ),
                  // SearchResults(searchInput: searchBox.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchResults extends StatelessWidget {
//   const SearchResults({Key? key, required this.searchInput}) : super(key: key);
//   final String searchInput;
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('products').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         List<Widget> searchResults = [];
//         if (snapshot.hasData) {
//           var allItems = snapshot.data.docs;
//           for (var item in allItems) {
//             imageUrl = item.data()['file'];
//             productName = item.data()['Name'];
//             description = item.data()['description'];
//             mrp = item.data()['mrp'];
//             price = item.data()['price'];
//             productId = item.data()['id'];
//             ownerId = item.data()['owner'];
//             String name = searchInput;
//             for (name in productName) {
//               print(name);
//               final tile = CardswithDetails(
//                 productname: productName,
//                 mrp: mrp.toString(),
//                 imageUrl: imageUrl,
//                 description: description,
//                 price: price.toString(),
//                 productId: productId,
//                 ownerid: ownerId,
//               );
//               searchResults.add(tile);
//             }
//           }
//           return Column(
//             children: searchResults,
//           );
//         }
//         return Text('some error');
//       },
//     );
//   }
// }
