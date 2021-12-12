
import 'package:cupboard_flutter/src/models/product_model.dart';
import 'package:cupboard_flutter/src/providers/cupboard_provider.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:date_time_picker/date_time_picker.dart';

class CupboardForm extends StatelessWidget {
  const CupboardForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final reqCupboardService = Provider.of<ReqCupboadService>(context);
    return ChangeNotifierProvider(
      create: (_) => CupboardProvider(reqCupboardService.selectCupboardDetail, reqCupboardService.selectCupboardDet),
      child: _CupboardForm(reqCupboardService: reqCupboardService),
    );
  }
}

class _CupboardForm extends StatelessWidget {

  final ReqCupboadService reqCupboardService;

  const _CupboardForm({ 
    Key? key, 
    required this.reqCupboardService 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final cupboardPro = Provider.of<CupboardProvider>(context);
    final cupboardProvider = cupboardPro.cupModel;
    final cupboardProviderDetail = cupboardPro.cupDetail;

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

                    TextFormField(
                      //keyboardType: TextInputType.number,
                      initialValue: cupboardProvider.nameCupBoard,
                      onChanged: (value) {
                        cupboardProvider.nameCupBoard = value;
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This field is required';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Name cupboard', 
                        labelText: 'Name cupboard',
                      ),
                    ),

                    const SizedBox(height: 20,),

                    SwitchListTile.adaptive(
                      activeTrackColor: Colors.blue,
                      activeColor: Colors.white,
                      title: const Text('Is Default'),
                      value: cupboardProvider.isDefault, 
                      onChanged: (value) => cupboardPro.updateIsDefault(value)
                    ),

                    const SizedBox(height: 20,),

                    DropdownButton<String>(
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      iconEnabledColor: Colors.indigo,
                      underline: Container(
                        height: 1,
                        color: Colors.indigo,
                      ),
                      hint: const Text('Select Product'),
                      value: cupboardProviderDetail.idProduct,
                      items: productService.products.map<DropdownMenuItem<String>>((ProductsModel value) {
                        return DropdownMenuItem<String>(
                          value: value.idProduct,
                          child: Text(value.nameProduct),
                        );
                      }).toList(),
                      onChanged: (value) => cupboardPro.valueSelect(value.toString())
                    ),

                    const SizedBox(height: 20,),

                    TextFormField(
                      initialValue: cupboardProviderDetail.amount.toString(),
                      onChanged: (value) {
                        cupboardProviderDetail.amount = value;
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
                      }
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
                        //print(val);
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'This fiel es required';
                        }
                      },
                      onSaved: (val) {
                        //print("valor print $val");
                      }
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
                      }
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
                        await reqCupboardService.saveOrUpdateCupboard(cupboardProvider, cupboardProviderDetail);
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

