import 'package:cupboard_flutter/src/services/prod_to_expire_service.dart';
import 'package:cupboard_flutter/src/services/product_expired_service.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:cupboard_flutter/src/widgets/home/tag_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
 //final color = const TextStyle(color: Colors.white);

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final producToExpire = Provider.of<ProductToExpireService>(context);
    final expiredProducts = Provider.of<ExpiredProdutService>(context);
    final cupboardLists = Provider.of<ReqCupboadService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            spacing: 10.0,
            children: <Widget>[
              Tag(
                icon: Icons.warning_amber_outlined, color: Colors.yellow, 
                texto: producToExpire.productToExpire.length == 1 ? "${producToExpire.productToExpire.length} producto esta por expirar" : "${producToExpire.productToExpire.length} productos estan por expirar",
                button: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.blue,
                  elevation: 0,
                  minWidth: double.infinity,
                  color: Colors.blue.shade400,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: const Text( 'Ver',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'toExpire');
                  }
                ),
              
              ),
              Tag(
                icon: Icons.warning_amber_outlined, color: Colors.red.shade500, 
                texto: expiredProducts.expiredProduct.length == 1 ? "${expiredProducts.expiredProduct.length} producto esta vencido" : "${expiredProducts.expiredProduct.length} productos están vencidos",
                button: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.blue,
                  elevation: 0,
                  minWidth: double.infinity,
                  color: Colors.blue.shade400,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: const Text( 'Ver',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'expiredProd');
                  }
                ),
              ),
      
              Tag(
                icon: Icons.check_circle_outline, color: Colors.green, 
                texto: "${cupboardLists.cupboardLista.length} productos estan disponibles",
                button: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.blue,
                  elevation: 0,
                  minWidth: double.infinity,
                  color: Colors.blue.shade400,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: const Text( 'Ver',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'listCupboard');
                  }
                ),
              ),
      
             
            ],
          ),
           ),
      ),
   );
  }
}