import 'package:flutter/material.dart';

class Tag extends StatelessWidget {

  final IconData icon;
  final Color? color;
  final String texto;
  final MaterialButton button;

  const Tag({
    Key? key,
    required this.icon,
    required this.texto, 
    this.color,
    required this.button,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        width: double.infinity,
        height: 210,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            _DetailsHome(icon: icon, texto: texto, color: color, button: button, )
          ],
          
        )
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


class _DetailsHome extends StatelessWidget {

  final String texto;
  final IconData icon;
  final Color? color;
  final MaterialButton button;

  const _DetailsHome( {
    Key? key, 
    required this.icon,
    required this.texto,
    this.color,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 210,
      decoration: _buildBoxDecoration(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Icon(icon, color: color, size: 100,),

            Text(texto, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10,),
            Container(
              child: button,
            ),

            
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() =>  const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))
    
  );
}

