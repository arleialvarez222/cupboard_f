
import 'package:cupboard_flutter/src/providers/mark_provider.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:cupboard_flutter/src/widgets/form/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormMark extends StatelessWidget {
  const FormMark({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markService = Provider.of<MarkService>(context);

    return ChangeNotifierProvider(
      create: (_) => MarkProvider(markService.selectMark),
      child: _MarkForm(markService: markService,),
    );
  }
}

class _MarkForm extends StatelessWidget {

  final MarkService markService;
  const _MarkForm({ 
    Key? key,
    required this.markService,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markForm = Provider.of<MarkProvider>(context);
    final markk = markForm.mark;

    return Scaffold(
    appBar: AppBar(
      title: const Text('Add Mark'),
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              width: double.infinity,
              decoration: _buildDecoration(),
              child: Form(
                key: markForm.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    
                    const SizedBox(height: 30,),
      
                    TextFormField(
                      initialValue: markk.mark,
                      onChanged: (value) => markk.mark = value,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo es obligatorio';
                        }
                      },
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Name mark', 
                        labelText: 'Name',
                      ),
                    ),
      
                    const SizedBox(height: 30,),
      
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
                      onPressed: markService.isSaving ? null : () async{
                        if(!markForm.isValidForm()) return;
                        await markService.saveOrUpdateMark(markForm.mark);
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