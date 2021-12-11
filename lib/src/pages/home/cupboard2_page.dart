
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:cupboard_flutter/src/widgets/home/card_cupboards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListCupboardPage extends StatelessWidget {
  const ListCupboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cupboardService = Provider.of<ReqCupboadService>(context);
    if(cupboardService.isloading) return const Loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupboard available'),
        centerTitle: true,
      ),
      body: cupboardService.cupboardLista.isNotEmpty ?
        ListView.builder(
          itemCount: cupboardService.cupboardLista.length,
          itemBuilder: (BuildContext context, int index){
            return ListCupboardCard(cupboard: cupboardService.cupboardLista[index], height: 140);
            }
        ) : const Center(child: Text('No hay productos para mostrar', style: TextStyle(fontSize: 20),),)
     
    );
  }
}