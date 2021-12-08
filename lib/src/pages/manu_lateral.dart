
import 'package:cupboard_flutter/src/pages/Products/products_page.dart';
import 'package:cupboard_flutter/src/pages/categories/categories.dart';
import 'package:cupboard_flutter/src/pages/cupboard/cupboard.dart';
import 'package:cupboard_flutter/src/pages/home/home_page.dart';
import 'package:cupboard_flutter/src/pages/marks/mark.dart';
import 'package:cupboard_flutter/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:provider/provider.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);


  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {

  List<ScreenHiddenDrawer> items = [];
  //final authService = Provider.of<AuthService>(context, listen: false);

  @override
  void initState() {
    items.add( ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Home",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: Colors.orange, 
          selectedStyle: const TextStyle(color: Colors.white),
        ),
       const HomePage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Products",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.orange,
          selectedStyle: const TextStyle(color: Colors.white),
        ),
        const ProductsPage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Categories",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.orange,
          selectedStyle: const TextStyle(color: Colors.white),
        ),
        const CategoriesPage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Cupboard",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.orange,
          selectedStyle: const TextStyle(color: Colors.white),
        ),
        const CupboardPage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Mark",
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 28.0 ),
          colorLineSelected: Colors.orange,
          selectedStyle: const TextStyle(color: Colors.white),
        ),
        const MarkPage()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final removeToken = Provider.of<AuthService>(context);
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.lightBlue.shade400,
      backgroundColorAppBar: Colors.lightBlue,
      screens: items,
      slidePercent: 50.0,
      verticalScalePercent: 90.0,
      contentCornerRadius: 40.0,
      actionsAppBar: <Widget>[IconButton(
        onPressed: (){
          
          final dialog = AlertDialog(
                  title: const Text('Cerrar sesión'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        removeToken.logout();
                         Navigator.pushReplacementNamed(context, 'login');
                      },
                    ),
                  ]);
                showDialog(context: context, builder: (_) => dialog);
        }, 
        icon: const  Icon(Icons.login_outlined)
      )],
        
    ); 
  }
}