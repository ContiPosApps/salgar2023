import 'package:salgar2023/models/models.dart';
import 'package:flutter/material.dart';
import 'package:salgar2023/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'animation_home';

  static final menuOptions = <MenuOption>[
    //  TODO: borrar home

    // MenuOption(
    //     route: 'animation_home',
    //     name: 'AnimationHome Screen',
    //     screen: const AnimationHomeScreen(),
    //),
    MenuOption(
      route: 'home',
      name: 'Catálogos',
      screen: const HomeScreen(),
    ),
    MenuOption(
      route: 'showcatalogo',
      name: 'Show Catálogo',
      screen: const ShowCatalogoScreen(),
    ),
    MenuOption(
      route: 'products',
      name: 'Productos',
      screen: const ProductsScreen(),
    ),
    MenuOption(
      route: 'materialesyacabados',
      name: 'Materiales y Acabados',
      screen: const HomeScreen(),
    ),
    MenuOption(
      route: 'contecto',
      name: 'Contacto',
      screen: const HomeScreen(),
    ),
     MenuOption(
      route: 'imgProducto',
      name: 'IMG Producto',
      screen: ImgProductoScreen(),
    ),
  ];
 

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({
      'animation_home': (BuildContext context) => const AnimatedHomeScreen()
    });

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
