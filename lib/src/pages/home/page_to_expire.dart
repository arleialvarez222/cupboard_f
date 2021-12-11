
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/prod_to_expire_service.dart';
import 'package:cupboard_flutter/src/widgets/home/card_to_expire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ToExpirePage extends StatelessWidget {
  const ToExpirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final toExpireService = Provider.of<ProductToExpireService>(context);
    if(toExpireService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product to expire'),
        centerTitle: true,
      ),
      body: toExpireService.productToExpire.isNotEmpty ?
        ListView.builder(
          itemCount: toExpireService.productToExpire.length,
          itemBuilder: (BuildContext context, int index){
            return ToExpireCard(toExpire: toExpireService.productToExpire[index], height: 138);
            }
        ) : const Center(child: Text('No hay productos para mostrar', style: TextStyle(fontSize: 20),),)
     
    );
  }
}