
import 'package:cupboard_flutter/src/models/product_expired_model.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ExpireProdCard extends StatelessWidget {

 final ExpiredProdModel expired;
 final double height;

  const ExpireProdCard({
    Key? key, 
    required this.expired, 
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 0),
        width: double.infinity,
        height: height,
        decoration: _borderCard(),
        child: Stack(
          alignment: Alignment.bottomLeft, 
          children: [
        
             _DetailCupboard(nombre: expired.product.nameProduct, fecha: Jiffy(expired.expirationDate).format("dd MMM yyyy"), height: height,),

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
 final String fecha;
 final double height;

  const _DetailCupboard({
    Key? key, 
    required this.nombre,  
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
            Text(nombre, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8,),

            /* Text(marca, style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.6),),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ), */

            const SizedBox(height: 8,),

            Text(fecha.toString(), style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.6),)),
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