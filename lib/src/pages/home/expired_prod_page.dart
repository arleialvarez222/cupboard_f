
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/product_expired_service.dart';
import 'package:cupboard_flutter/src/widgets/home/card_expired_prod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ExpireProdPage extends StatelessWidget {
  const ExpireProdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final expireProducService = Provider.of<ExpiredProdutService>(context);
    if(expireProducService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product expired'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: expireProducService.expiredProduct.length,
        itemBuilder: (BuildContext context, int index){
          return ExpireProdCard(expired: expireProducService.expiredProduct[index], height: 100);
          }
      ), 
     
    );
  }
}