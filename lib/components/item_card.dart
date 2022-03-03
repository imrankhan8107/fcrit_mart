import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_popup.dart';

class CardswithDetails extends StatefulWidget {
  const CardswithDetails({
    Key? key,
    required this.productname,
    required this.mrp,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.productId,
    required this.ownerid,
  }) : super(key: key);

  final String productname;
  final String mrp;
  final String price;
  final String imageUrl;
  final String description;
  final String productId;
  final String ownerid;

  @override
  State<CardswithDetails> createState() => _CardswithDetailsState();
}

class _CardswithDetailsState extends State<CardswithDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return BottomPopup(
                  imageUrl: widget.imageUrl,
                  productName: widget.productname,
                  mrp: widget.mrp,
                  price: widget.price,
                  description: widget.description,
                  id: widget.productId,
                  ownerId: widget.ownerid,
                );
              },
            );
          },
          style: ListTileStyle.list,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: getImage(widget.imageUrl),
          ),
          title: Text(widget.productname),
          subtitle: Text(widget.price),
          // trailing: Icon(Icons.more_vert),
          // isThreeLine: true,
        ),
      ),
    );
  }
}
