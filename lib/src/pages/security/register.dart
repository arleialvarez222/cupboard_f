
import 'package:cupboard_flutter/src/global_input/global_input.dart';
import 'package:cupboard_flutter/src/providers/register_provider.dart';
import 'package:cupboard_flutter/src/services/auth_service.dart';
import 'package:cupboard_flutter/src/widgets/auth/auth_bg.dart';
import 'package:cupboard_flutter/src/widgets/auth/card_conten.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 150,),

              CardConten(
                child: Column(
                  children: [

                    const SizedBox(height: 10,),

                    Text('Regístrate!', style: Theme.of(context).textTheme.headline4,),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (_) => RegisterFormProvider(),
                      child: const _LoginForm(),
                    ),
                   // _LoginForm(),
                  ],
                )
              ),

              const SizedBox(height: 30,),

              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                 child: const Text('Inicia sesion', style: TextStyle(fontSize: 18, color: Colors.white),),
              ),

              const SizedBox(height: 50,),
            ],
          ),
        )
      ),
   );

  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Form(

      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        //lista de widgets de formularios
        children: [

          TextFormField(
              initialValue: "",
              onChanged: (value) => registerForm.nombreCompleto = value,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'Este campo es obligatorio';
                }
              },
              decoration: GlobalInput.authInputDecoration(
              hintText: 'Arlei Alvarez',
              labelText: 'Full Name',
              prefixIcon: Icons.person,
            ),
          ),

          const SizedBox(height: 20,),

          TextFormField(
              initialValue: "",
              onChanged: (value) => registerForm.userName = value,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'Este campo es obligatorio';
                }
              },
              decoration: GlobalInput.authInputDecoration(
              hintText: 'UserName',
              labelText: 'User Name',
              prefixIcon: Icons.people,
            ),
          ),

          const SizedBox(height: 20,),

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: GlobalInput.authInputDecoration(
              hintText: 'ejemplo@gmail.com',
              labelText: 'E-mail',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => registerForm.email = value,
            validator:(value) {

              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                ? null
                : 'No es un correo valido';
            }
          ),

          const SizedBox(height: 20),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: GlobalInput.authInputDecoration(
              hintText: '*******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => registerForm.password = value,
            validator: (value){
              return (value != null && value.length >= 6)
                ? null
                : 'Ingrese almenos 6 caracteres';
            },
          ),

          const SizedBox(height: 20),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text( registerForm.isLoading ? 'Cargando...' :'Ingresar', 
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: registerForm.isLoading ? null : () async {

              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);

              if( !registerForm.isValidForm() ) return;

              registerForm.isLoading = true;

              final String? errorMessage =  await authService.createUser(registerForm.nombreCompleto, registerForm.userName, registerForm.email, registerForm.password,  );

              if(errorMessage == null){
                 Navigator.pushReplacementNamed(context, 'login');
              }else{
                //print(errorMessage);
                registerForm.isLoading = false;
              }
            
            }
          ),

        ],
      )
    );
  }
}