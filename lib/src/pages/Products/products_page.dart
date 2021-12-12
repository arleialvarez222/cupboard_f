
import 'package:cupboard_flutter/src/models/product_model.dart';
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    if(productService.isloading) return const Loading();
    return Scaffold(
      body:ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(productM: productService.products[index]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          productService.selectProduct = ProductsModel(
             
            nameProduct: "", 
            idMark: productService.products.first.idMark, 
            barCode: "", 
          );
          Navigator.pushNamed(context, 'formProduct');
        },
      ),
    );
   
  }
}