import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  static const String id = 'Product_page';

  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text('Product Page')),
      ),
    );
  }
}
