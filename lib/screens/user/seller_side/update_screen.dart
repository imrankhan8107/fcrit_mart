import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:fcrit_mart/screens/user/seller_side/seller_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateItemDetails extends StatefulWidget {
  const UpdateItemDetails(
      {Key? key,
      required this.imageUrl,
      required this.productName,
      required this.mrp,
      required this.price,
      required this.description,
      required this.productId,
      required this.ownerId})
      : super(key: key);
  final String imageUrl;
  final String productName;
  final String mrp;
  final String price;
  final String description;
  final String productId;
  final String ownerId;

  @override
  State<UpdateItemDetails> createState() => _UpdateItemDetailsState();
}

class _UpdateItemDetailsState extends State<UpdateItemDetails> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _name =
        TextEditingController(text: widget.productName);
    final TextEditingController _description =
        TextEditingController(text: widget.description);
    final TextEditingController _mrp = TextEditingController(text: widget.mrp);
    final TextEditingController _price =
        TextEditingController(text: widget.price);
    Widget updateTextFields({
      required String fieldName,
      required TextEditingController controller,
      required TextInputType inputType,
      required int maxLines,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              '$fieldName : ',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Textfieldinput(
            textEditingController: controller,
            hinttext: 'Update $fieldName',
            textInputType: inputType,
            maxlines: maxLines,
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.productName.toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lobster',
              letterSpacing: 3,
            ),
          ),
        ),
        body: ListView(
          children: [
            updateTextFields(
              fieldName: 'NAME',
              controller: _name,
              inputType: TextInputType.text,
              maxLines: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'IMAGE : ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: 'Images cannot be updated');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 300,
                child: getImage(widget.imageUrl),
              ),
            ),
            updateTextFields(
              fieldName: 'MRP',
              controller: _mrp,
              inputType: TextInputType.number,
              maxLines: 1,
            ),
            updateTextFields(
              fieldName: 'PRICE',
              controller: _price,
              inputType: TextInputType.number,
              maxLines: 1,
            ),
            updateTextFields(
              fieldName: 'DESCRIPTION',
              controller: _description,
              inputType: TextInputType.text,
              maxLines: 5,
            ),
            GestureDetector(
              onTap: () {
                if (int.parse(_mrp.text) < int.parse(_price.text)) {
                  Fluttertoast.showToast(
                      msg: 'Price cannot be Greater than MRP');
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: SizedBox(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator()),
                        );
                      });
                  FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.productId)
                      .update({
                    'Name': _name.text,
                    'description': _description.text,
                    'mrp': int.parse(_mrp.text, onError: (String val) {
                      return 0;
                    }),
                    'price': int.parse(_price.text, onError: (String val) {
                      return 0;
                    })
                  });
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Details have been updated'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.popUntil(context,
                                    ModalRoute.withName(Sellerpage.id));
                              },
                            )
                          ],
                        );
                      });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: kGradientcolor,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Center(child: Text('Update Details')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
