import 'package:dukaan/widgets/carousel.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dukaan'),
      ),
      body: Column(
        children: [
          Expanded(child: Carousel()),
          Expanded(
            child: ProductsGrid(),
          ),
        ],
      ),
    );
  }
}
