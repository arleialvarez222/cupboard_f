
import 'package:cupboard_flutter/src/providers/categories_provider.dart';
import 'package:cupboard_flutter/src/services/categori_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesForm extends StatelessWidget {
  const CategoriesForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categoryService = Provider.of<CategoriService>(context);

    return ChangeNotifierProvider(
      create: (_) => CategoriProvider(categoryService.selCategorie),
      child: _CategoriForm(categoryService: categoryService,),
    );
    
  }
}

class _CategoriForm extends StatelessWidget {

  final CategoriService categoryService;
  const _CategoriForm({ 
    Key? key,
    required this.categoryService,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categoryForm = Provider.of<CategoriProvider>(context);
    final category = categoryForm.categoria;

    return Scaffold(
    appBar: AppBar(
      title: const Text('Add Category'),
      centerTitle: true,
    ),
    body: Center(
      child: GestureDetector(
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
          if(!focus.hasPrimaryFocus && focus.hasFocus){
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: SingleChildScrollView(
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              width: double.infinity,
              decoration: _buildDecoration(),
              child: Form(
                key: categoryForm.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    
                    const SizedBox(height: 30,),
      
                    TextFormField(
                      initialValue: category.name,
                      onChanged: (value) => category.name = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo es obligatorio';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Name category', 
                        labelText: 'Name',
                      ),
                    ),
      
                    const SizedBox(height: 30,),
      
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.blue,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        child: const Text( 'Save',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      onPressed: categoryService.isSaving ? null : () async{
                        if(!categoryForm.isValidForm()) return;
                        await categoryService.saveOrUpdateCategory(categoryForm.categoria);
                        Navigator.of(context).pop();
                        
                      },
                    ),
      
              const SizedBox(height: 20,),
      
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                minWidth: double.infinity,
                color: Colors.red,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: const Text( 'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  //Navigator.pushReplacementNamed(context, 'categories');
                },
              ),
      
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    ),
  );
  }
}

BoxDecoration _buildDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      offset: Offset(0,5),
      blurRadius: 5
    )
  ]
);