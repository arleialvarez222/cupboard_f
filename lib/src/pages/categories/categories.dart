
import 'package:cupboard_flutter/src/models/categories_model.dart';
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/categori_service.dart';
import 'package:cupboard_flutter/src/widgets/categories/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categoriService = Provider.of<CategoriService>(context);
    if(categoriService.isloading) return const Loading();

    return Scaffold(

      body: ListView.builder(
        itemCount: categoriService.categories.length,
        itemBuilder: (BuildContext context, int index){
          return CategoryCard(category: categoriService.categories[index], height: 70);
          }
      ), 


      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          categoriService.selCategorie = Categories(
            name: '',
          );
          Navigator.pushNamed(context, 'formCategory');
        },
      ),
     
    );
  }
}