import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salgar2023/router/app_routes.dart';
import 'package:salgar2023/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  
  // Bloquear la orientación en modo vertical
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salgar 2023',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      // Por si no existe la ruta, navega a esa por defecto
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
