
import 'package:cupboard_flutter/src/global_input/global_input.dart';
import 'package:cupboard_flutter/src/providers/login_provider.dart';
import 'package:cupboard_flutter/src/services/auth_service.dart';
import 'package:cupboard_flutter/src/services/message_service.dart';
import 'package:cupboard_flutter/src/widgets/auth/auth_bg.dart';
import 'package:cupboard_flutter/src/widgets/auth/card_conten.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 250,),

              CardConten(
                child: Column(
                  children: [

                    const SizedBox(height: 10,),

                    Text('Login', style: Theme.of(context).textTheme.headline4,),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                   // _LoginForm(),
                  ],
                )
              ),

              const SizedBox(height: 50,),

              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                 child: const  Text('Regístrate', style: TextStyle(fontSize: 18, color: Colors.white),),
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

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
    
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            //initialValue: "alvarezarlei222@gmail.com",
            keyboardType: TextInputType.emailAddress,
            decoration: GlobalInput.authInputDecoration(
              hintText: 'ejemplo@gmail.com',
              labelText: 'E-mail',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email = value,
            validator:(value) {
    
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
    
              return regExp.hasMatch(value ?? '')
                ? null
                : 'No es un correo valido';
            }
          ),
    
          const SizedBox(height: 30),
    
          TextFormField(
            autocorrect: false,
            obscureText: true,
            //initialValue: 'Baronrojo222',
            keyboardType: TextInputType.emailAddress,
            decoration: GlobalInput.authInputDecoration(
              hintText: '*******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value){
              return (value != null && value.length >= 6)
                ? null
                : 'Ingrese almenos 6 caracteres';
            },
          ),
    
          const SizedBox(height: 30),
    
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text( loginForm.isLoading ? 'Cargando...' :'Ingresar', 
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading ? null : () async {
    
               FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);
    
              if( !loginForm.isValidForm() ) return;
    
              loginForm.isLoading = true;
    
              final String? errorMessage =  await authService.login(loginForm.email, loginForm.password);
    
              if(errorMessage == null){
                Navigator.pushReplacementNamed(context, 'menuLateral');
              }else{
                //print('error login: $errorMessage');
                MessageService.showSnackbar(errorMessage);
                loginForm.isLoading = false;
              }
    
            
            }
          ),
    
        ],
      )
    );
  }
}