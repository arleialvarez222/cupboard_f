
import 'package:cupboard_flutter/src/pages/Products/product_form.dart';
import 'package:cupboard_flutter/src/pages/Products/products_page.dart';
import 'package:cupboard_flutter/src/pages/categories/categories.dart';
import 'package:cupboard_flutter/src/pages/categories/form_categories.dart';
import 'package:cupboard_flutter/src/pages/cupboard/cupboard_form.dart';
import 'package:cupboard_flutter/src/pages/cupboard/edit_cupboard_form.dart';
import 'package:cupboard_flutter/src/pages/home/cupboard2_page.dart';
import 'package:cupboard_flutter/src/pages/home/expired_prod_page.dart';
import 'package:cupboard_flutter/src/pages/home/home_page.dart';
import 'package:cupboard_flutter/src/pages/home/page_to_expire.dart';
import 'package:cupboard_flutter/src/pages/manu_lateral.dart';
import 'package:cupboard_flutter/src/pages/marks/form_mark.dart';
import 'package:cupboard_flutter/src/pages/marks/mark.dart';
import 'package:cupboard_flutter/src/pages/security/login.dart';
import 'package:cupboard_flutter/src/pages/security/register.dart';
import 'package:cupboard_flutter/src/services/auth_service.dart';
import 'package:cupboard_flutter/src/services/categori_service.dart';
import 'package:cupboard_flutter/src/services/cupboard_service.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:cupboard_flutter/src/services/prod_to_expire_service.dart';
import 'package:cupboard_flutter/src/services/product_expired_service.dart';
import 'package:cupboard_flutter/src/services/products_service.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

void main(){
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppState());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CategoriService()),
        ChangeNotifierProvider(create: (_) => MarkService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => ProductToExpireService()),
        ChangeNotifierProvider(create: (_) => ExpiredProdutService()),
        ChangeNotifierProvider(create: (_) => CupboardService()),
        ChangeNotifierProvider(create: (_) => ReqCupboadService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (_) => const LoginScreen(),
        'register' : (_) => const RegisterScreen(),
        'home' : (_) => const HomePage(),
        'menuLateral': (_) => const MenuLateral(),
        'categories' : (_) => const CategoriesPage(),
        'product': (_) => const ProductsPage(),
        'formProduct': (_) => const ProductForm(),
        'formCategory': (_) => const CategoriesForm(),
        'cupboardForm': (_) => const CupboardForm(),
        'mark': (_) => const MarkPage(),
        'formMark': (_) => const FormMark(),
        'toExpire': (_) => const ToExpirePage(),
        'expiredProd': (_) => const ExpireProdPage(),
        'listCupboard': (_) => const ListCupboardPage(),
        'editCupboard': (_) => const EditCupboardForm(),
      },

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.blue
        )
      ),
    );
  }
}