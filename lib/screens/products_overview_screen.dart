import 'package:dukaan/providers/cart.dart';
import 'package:dukaan/widgets/drawer.dart';
import 'package:dukaan/widgets/badge.dart';
import 'package:dukaan/widgets/carousel.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dukaan'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favourites'),
                  value: FilterOptions.Favourites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All)
            ],
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _showOnlyFavourites? Text(
            'Favourites',
            style: TextStyle(
                fontSize: 20
            ),
          ) :Expanded(child: Carousel(_showOnlyFavourites)),
          Expanded(
            child: ProductsGrid(_showOnlyFavourites),
          ),
        ],
      ),
    );
  }
}
