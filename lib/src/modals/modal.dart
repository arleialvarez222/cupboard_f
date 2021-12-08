import 'package:cupboard_flutter/src/global_input/global_input.dart';
import 'package:cupboard_flutter/src/labels/c_label.dart';
import 'package:flutter/material.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({ Key? key }) : super(key: key);

  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

  String nombre = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.only(top: 10, left: 10),
      decoration: builBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("Nueva Categoria", style: Labels.h1.copyWith(color: Colors.white),),

              IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                icon: const Icon(Icons.close, color: Colors.white),
              ),

            ],
          ),

          Divider(color: Colors.white.withOpacity(0.3),),

          const SizedBox(height: 20,),

          TextFormField(
            initialValue: "",
            onChanged: (value) => nombre = value,
            decoration: GlobalInput.loginInputDecoration(
              hint: "Nombre Categoria", 
              label: "Categoria", 
            ),
          )

        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color(0xff0F2041),
    boxShadow: [
      BoxShadow(color: Colors.black26),
    ]
  );
}