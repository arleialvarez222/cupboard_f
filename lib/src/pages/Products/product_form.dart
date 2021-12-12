import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:cupboard_flutter/src/providers/product_provider.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductProvider(productService.selectProduct),
      child: _FormProduct(productService: productService,),
    );
  }
}

class _FormProduct extends StatelessWidget {

  final ProductService productService;
  const _FormProduct({ 
    Key? key, 
    required this.productService 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markService = Provider.of<MarkService>(context);
    final productPro = Provider.of<ProductProvider>(context);
    final productProvider = productPro.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              width: double.infinity,
              decoration: _buildBoxDecoration(),
              child: Form(
                key: productPro.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [

                    const SizedBox(height: 30,),

                    TextFormField(
                      initialValue: productProvider.nameProduct,
                      onChanged: (value) => productProvider.nameProduct = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Name of product', 
                        labelText: 'Name',
                      ),
                    ),

                    const SizedBox(height: 30,),

                    DropdownButton<String>(
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      iconEnabledColor: Colors.indigo,
                      underline: Container(
                        height: 1,
                        color: Colors.indigo,
                      ),
                      hint: const Text('Select Mark'),
                      value: productProvider.idMark,
                      items: markService.marks.map((Mark value) {
                        return DropdownMenuItem<String>(
                          value: value.idTrademark,
                          child: Text(value.mark),
                        );
                      }).toList(),
                      onChanged: (value) => productPro.valueSelect(value.toString())
                        
                      
                    ),

                    const SizedBox(height: 30,),

                    TextFormField(
                      initialValue: productProvider.barCode,
                      onChanged: (value) => productProvider.barCode = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Code of product', 
                        labelText: 'Code',
                      ),
                    ),

                    const SizedBox(height: 40,),

                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.blue,
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.blue,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        child: const Text( 'Save',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      onPressed: productService.isSaving ? null : () async {
                        if(!productPro.isValidForm()) return;
                        await productService.saveOrUpdateProduct(productPro.product);
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
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );

  
}








/*import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:cupboard_flutter/src/providers/product_provider.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductProvider(productService.selectProduct),
      child: _FormProduct(productService: productService,),
    );
  }
}

 class _FormProduct extends StatelessWidget {

  final ProductService productService;
  const _FormProduct({ 
    Key? key, 
    required this.productService 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markService = Provider.of<MarkService>(context);
    final productPro = Provider.of<ProductProvider>(context);
    final productProvider = productPro.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              width: double.infinity,
              decoration: _buildBoxDecoration(),
              child: Form(
                key: productPro.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [

                    const SizedBox(height: 30,),

                    TextFormField(
                      initialValue: productProvider.nameProduct,
                      onChanged: (value) => productProvider.nameProduct = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Name of product', 
                        labelText: 'Name',
                      ),
                    ),

                    const SizedBox(height: 30,),

                    DropdownButton<String>(
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      iconEnabledColor: Colors.indigo,
                      underline: Container(
                        height: 1,
                        color: Colors.indigo,
                      ),
                      hint: const Text('Select Mark'),
                      //value: dropdowValue,
                      items: markService.marks.map<DropdownMenuItem<String>>((Mark value) {
                        return DropdownMenuItem<String>(
                          value: value.idTrademark,
                          child: Text(value.mark),
                        );
                      }).toList(),
                      onChanged: (value) {
                        productProvider.idMark = value.toString();
                        //print('valor del select $value');
                      },
                    ),

                    const SizedBox(height: 30,),

                    TextFormField(
                      initialValue: productProvider.barCode,
                      onChanged: (value) => productProvider.barCode = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Code of product', 
                        labelText: 'Code',
                      ),
                    ),

                    const SizedBox(height: 40,),

                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.blue,
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.blue,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        child: const Text( 'Save',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      onPressed: productService.isSaving ? null : () async {
                        if(!productPro.isValidForm()) return;
                        await productService.saveOrUpdateProduct(productPro.product);
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
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );
} */