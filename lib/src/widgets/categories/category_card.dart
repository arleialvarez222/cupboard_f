
import 'package:cupboard_flutter/src/models/categories_model.dart';
import 'package:cupboard_flutter/src/services/categori_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  
  final Categories category;
  final double height;

  const CategoryCard({
    Key? key, 
    required this.category,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categoriService = Provider.of<CategoriService>(context);
    final index = categoriService.categories.indexWhere((e) => e.idcategory == category.idcategory);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 0),
        width: double.infinity,
        height: height,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft, 
          children: [
        
            _DetailsCategory(nombre: category.name, height: height,),

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
                categoriService.selCategorie = categoriService.categories[index];
                Navigator.pushNamed(context, 'formCategory');
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
                  title: Text('¿Desea eliminar la categoria ${category.name}?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                        await categoriService.deleteCategory('${category.idcategory}');
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

class _DetailsCategory extends StatelessWidget {
  final dynamic nombre;
  final double height;
  /* IconData edit;
  IconData delete; */

  const _DetailsCategory( {
    Key? key, 
    required this.nombre, 
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
