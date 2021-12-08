
import 'package:cupboard_flutter/src/models/product_model.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:handling_cupboard/src/models/categories_model.dart';

class ProductCard extends StatelessWidget {

  final ProductsModel productM;
  //final Trademark tradeMark;/
  final dynamic marca;

  const ProductCard({
    Key? key, 
    required this.productM,
    //required this.tradeMark,
    this.marca, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final index = productService.products.indexWhere((e) => e.idProduct == productM.idProduct);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 0),
        width: double.infinity,
        height: 110,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft, 
          children: [
        
             _DetailsProduct(nombre: productM.nameProduct, marca: productM.trademark!.mark,),

             Positioned(
              top: 30,
              right: 40,
              child: IconButton(
              splashRadius: 20,
              splashColor: Colors.deepOrange,
              icon: Icon(
                Icons.edit,
                color: Colors.blue.withOpacity(0.8),
              ),
              onPressed: () {
                productService.selectProduct = productService.products[index];
                Navigator.pushNamed(context, 'formProduct');
              },
            ),
            ),

            Positioned(
              top: 30,
              right: 0,
              child: IconButton(
              splashRadius: 20,
              splashColor: Colors.deepOrange,
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.8),
              ),
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('¿Desea eliminar el producto ${productM.nameProduct}?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                        await productService.deleteProduct('${productM.idProduct}');
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
                showDialog(context: context, builder: (_) => dialog);
              },
            ),
            ),

          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _DetailsProduct extends StatelessWidget {

  final dynamic nombre;
  //final String code;
  final dynamic marca;

  const _DetailsProduct( {
    Key? key, 
    required this.nombre, 
    //required this.code, 
    this.marca
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        width: double.infinity,
        height: 110,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(nombre, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10,),

            Text(marca, style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.7),),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

           /*  const SizedBox(height: 10,),

            Text(code, style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.7),),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ), */
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
    
  );
}