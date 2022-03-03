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
          IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.heart))
        ],
      ),
      body: AllProductDetails(),
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
