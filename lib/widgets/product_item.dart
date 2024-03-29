import 'package:dukaan/providers/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;


  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id
          );
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
          fit: BoxFit.cover,
        ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                product.toggleFavouriteStatus();
                  }),
            ),
            title: Text(product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(icon: Icon(Icons.add_shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Added item to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.white,
                      onPressed: (){
                        cart.removeSingleItem(product.id);
                      },),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
