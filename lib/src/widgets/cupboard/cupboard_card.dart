
import 'package:cupboard_flutter/src/models/cupboard_model.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class CupboardCard extends StatelessWidget {

 final CupboardModel cupboard;
 final double height;

  const CupboardCard({
    Key? key, 
    required this.cupboard, 
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cupboardService = Provider.of<ReqCupboadService>(context);
    final index = cupboardService.cupboardList.indexWhere((e) => e.idCupBoard == cupboard.idCupBoard);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        width: double.infinity,
        height: height,
        decoration: _borderCard(),
        child: Stack(
          alignment: Alignment.bottomLeft, 
          children: [
        
             _DetailCupboard(nombre: cupboard.product!.nameProduct, cantidad: cupboard.amount, fecha: Jiffy(cupboard.expirationDate).format("dd MMM yyyy"), height: height,),

             Positioned(
              top: 10,
              right: 40,
              child: IconButton(
              splashRadius: 20,
              splashColor: Colors.deepOrange,
              icon: Icon(
                Icons.edit,
                color: Colors.blue.withOpacity(0.8),
              ),
              onPressed: () {
                cupboardService.selectCupboard = cupboardService.cupboardList[index];
                Navigator.pushNamed(context, 'editCupboard');
              },
            ),
            ),

             Positioned(
              top: 10,
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
                  title: Text('¿Desea eliminar el cupboard ${cupboard.product!.nameProduct}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                        await cupboardService.deleteCupboard('${cupboard.idCupBoard}');
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

  BoxDecoration _borderCard() => BoxDecoration(
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

class _DetailCupboard extends StatelessWidget {

  final String nombre;
  final int cantidad;
  final String fecha;
  final double height;

  const _DetailCupboard({
    Key? key, 
    required this.nombre, 
    required this.cantidad,
    required this.fecha,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: height,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name:', style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6),)),
            const SizedBox(height: 5,),
            Text(nombre, style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10,),

            Text('Amount:', style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6),)),
            const SizedBox(height: 5,),
            Text(cantidad.toString(), style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10,),

            Text('Expire Date:', style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6),)),
            const SizedBox(height: 5,),
            Text(fecha.toString(), style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() =>  const BoxDecoration(
    color: Colors.white,
    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20) ,bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
    
  );
}