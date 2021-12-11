
import 'package:cupboard_flutter/src/models/product_model.dart';
import 'package:cupboard_flutter/src/providers/edit_cupboart_provider.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:date_time_picker/date_time_picker.dart';

class EditCupboardForm extends StatelessWidget {
  const EditCupboardForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final reqCupboardService = Provider.of<ReqCupboadService>(context);
    return ChangeNotifierProvider(
      create: (_) => EditCupboardProvider(reqCupboardService.selectCupboard),
      child: _EditCupboardForm(reqCupboardService: reqCupboardService),
    );
  }
}

class _EditCupboardForm extends StatelessWidget {

  final ReqCupboadService reqCupboardService;

  const _EditCupboardForm({ 
    Key? key, 
    required this.reqCupboardService 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final cupboardPro = Provider.of<EditCupboardProvider>(context);
    //final cupboardProvider = cupboardPro.cupModel;
    final cupboardProviderDetail = cupboardPro.cupModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add cupboard"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              width: double.infinity,
              //height: double.infinity,
              decoration: _buildBoxDecoration(),
              child: Form(
                key: cupboardPro.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [

                    DropdownButton<String>(
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      iconEnabledColor: Colors.indigo,
                      underline: Container(
                        height: 1,
                        color: Colors.indigo,
                      ),
                      hint: const Text('Select Product'),
                      //value: _value,
                      selectedItemBuilder: (BuildContext context) {
                        return productService.products.map<Widget>((ProductsModel item) {
                        return Text('item ${item.nameProduct}');
                        }).toList();
                      },
                      items: productService.products.map<DropdownMenuItem<String>>((ProductsModel value) {
                        return DropdownMenuItem<String>(
                          value: value.idProduct,
                          child: Text(value.nameProduct),
                        );
                      }).toList(),
                      onChanged: (value) {
                        cupboardProviderDetail.idProduct = value.toString();
                        //print('valor del select $value');
                      },
                    ),

                    const SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: cupboardProviderDetail.amount.toString(),
                      onChanged: (value) {
                       //String _value = cupboardProviderDetail.amount.toString(),
                        //cupboardProviderDetail.amount = value;
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Amount', 
                        labelText: 'Amount',
                      ),
                    ),

                    const SizedBox(height: 20,),

                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'd MMM, yyyy',
                      //icon: Icon(Icons.event),
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Date entry', 
                        labelText: 'Date entry',
                      ),
                      initialValue: cupboardProviderDetail.entryDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date entry',
                      onChanged: (val) {
                        cupboardProviderDetail.entryDate = val;
                        //print(val);
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This fiel es required';
                        }
                      },
                      onSaved: (val) {
                        //print("valor print $val");
                      },
                    ),

                    const SizedBox(height: 20,),

                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'd MMM, yyyy',
                      //icon: Icon(Icons.event),
                      initialValue: cupboardProviderDetail.exitDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date exit',
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Date exit', 
                        labelText: 'Date exit',
                      ),
                      onChanged: (val) {
                        cupboardProviderDetail.exitDate = val;
                        //(val);
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This fiel es required';
                        }
                      },
                      onSaved: (val) {
                        //print("valor print $val");
                      },
                    ),

                    const SizedBox(height: 20,),

                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'd MMM, yyyy',
                      //icon: Icon(Icons.event),
                      initialValue: cupboardProviderDetail.expirationDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date expire',
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Date expire', 
                        labelText: 'Date expire',
                      ),
                      onChanged: (val) {
                        cupboardProviderDetail.expirationDate = val;
                        //print(val);
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This fiel es required';
                        }
                      },
                      onSaved: (val) {
                        //print("valor print $val");
                      },
                    ),

                    const SizedBox(height: 20,),
                   
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
                      onPressed: reqCupboardService.isSaving ? null : () async{
                        
                        if(!cupboardPro.isValidForm()) return;
                        await reqCupboardService.updateCupboard(cupboardProviderDetail);
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

