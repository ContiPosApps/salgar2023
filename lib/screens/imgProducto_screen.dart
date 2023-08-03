import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:salgar2023/classes/classes.dart';
import 'package:salgar2023/theme/app_theme.dart';
import 'package:salgar2023/widgets/widgets.dart';

class ImgProductoScreen extends StatefulWidget {
  const ImgProductoScreen({Key? key}) : super(key: key);

  @override
  _ImgProductoScreenState createState() => _ImgProductoScreenState();
}

class _ImgProductoScreenState extends State<ImgProductoScreen> {
  final ValueNotifier<int> _selectedMainImageIndex = ValueNotifier<int>(0);
  List<Producto> allProductos = [];
  late int idTipo;
  int? idSubTipo;
  late int idUrl;
  late TipoProducto tipo;
  final TransformationController _controller = TransformationController();
  var selectedLanguage = "es";
  late String gamaArg;
  late Gama gama;

  void onLanguageChanged(String? newValue) {
    setState(() {
      selectedLanguage = newValue ?? "es";
    });
    LanguageUtils.guardarIdiomaSeleccionado(selectedLanguage);
  }

  @override
  void initState() {
    super.initState();
    LanguageUtils.getSelectedLanguage().then((language) {
      setState(() {
        selectedLanguage = language ?? "es";
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      idTipo = args['idTipo'] as int;
      idSubTipo = args['idSubTipo'] as int?;
      idUrl = args['idUrl'] as int;
      tipo = args['tipo'];
      gamaArg = args['gamaName'];
      gama = args['gama'];
        print(gama.title_es);
        print(gama.title_en);
        print(gama.title_fr);
        print("$idSubTipo  $idTipo");

      if (idSubTipo != null && idSubTipo != 0) {
        print("entra $idSubTipo $idTipo");
        _loadAllProductosSubTipo(idSubTipo!);
      } else {
        _loadAllProductos();
      }
    });
  }

  void _loadAllProductos() async {
    try {
      final List<Producto> loadedProductos = await DB.productos(idTipo);
      setState(() {
        allProductos = loadedProductos;
      });
    } catch (error) {
      print('Error al cargar los productos: $error');
    }
  }

  void _loadAllProductosSubTipo(int idSubTipo) async {
    try {
      final List<Producto> loadedProductos =
          await DB.productosPorSubTipo(idSubTipo);
      print("load  $loadedProductos");
      setState(() {
        allProductos = loadedProductos;
        print("all $allProductos");
      });
    } catch (error) {
      print('Error al cargar los productos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(
        child: MenuWidget(),
      ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              _CustomAppBar(
                title: _devolverNombreIdioma(tipo, selectedLanguage, gama),
                selectedLanguage: selectedLanguage,
                onLanguageChanged: onLanguageChanged,
              ),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    final productos = allProductos;

                    return Column(
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: _selectedMainImageIndex,
                          builder: (context, value, child) {
                            final mainProductoImage = productos.isNotEmpty
                                ? productos[value].img
                                : '';

                            return GestureDetector(
                              onDoubleTap: () {
                                if (_controller.value.getMaxScaleOnAxis() >
                                    1.0) {
                                  _controller.value = Matrix4.identity();
                                } else {
                                  _controller.value = Matrix4.identity()
                                    ..scale(2.0);
                                }
                              },
                              child: InteractiveViewer(
                                scaleEnabled: true,
                                panEnabled: true,
                                minScale: 0.1,
                                maxScale: 4,
                                transformationController: _controller,
                                child: Image.asset(
                                  mainProductoImage,
                                  fit: BoxFit.contain,
                                  height: 400,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: productos.asMap().entries.map((entry) {
                              final index = entry.key;
                              final producto = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  _selectedMainImageIndex.value = index;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      producto.img,
                                      width: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryDark,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () async {
                  print(idTipo);
                  final List<Url> urls = await DB.urlsPorTipo(idUrl);
                  print(urls);
                  if (urls.isNotEmpty) {
                    final url = _getUrlForLanguage(urls[0], selectedLanguage);
                    if (url != null) {
                      print(url);
                      await FlutterWebBrowser.openWebPage(url: url);
                    }
                  }
                },
                child: const Icon(
                  Icons.language,
                  color: AppTheme.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String selectedLanguage;
  final void Function(String?)? onLanguageChanged;

  const _CustomAppBar({
    Key? key,
    required this.title,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(title),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    dropdownColor: Colors.black,
                    iconEnabledColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    onChanged: onLanguageChanged,
                    items: <String>['es', 'en', 'fr']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    padding: EdgeInsets.only(right: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _getUrlForLanguage(Url url, String language) {
  switch (language) {
    case 'es':
      return url.url_es;
    case 'en':
      return url.url_en;
    case 'fr':
      return url.url_fr;
    default:
      return null;
  }
}

String _devolverNombreIdioma(
    TipoProducto tipo, String selectedLanguage, Gama gama) {
  print("entra en devolver idioma");
 /* switch (selectedLanguage) {
    case "es":
      switch (tipo.id) {
        case 170:
          return "Lavabo ALLIANCE";
        case 169:
          return "Lavabo MAM";
        case 175:
          return "Lavabo F35";
        case 176:
          return "Lavabo F40";
        case 178:
          return "Lavabo UNIIQ";
        case 172:
          return "Lavabos de posar";
        case 182:
          return "Espejos";
        case 181:
          return "Apliques";
        case 192:
          return "Puertas correderas";
        case 188:
          return "Platos";
        case 203:
          return "De paso y fijas";
      }
      break;
    case "en":
      switch (tipo.id) {
        case 170:
          return "Basin ALLIANCE";
        case 169:
          return "Basin MAM";
        case 175:
          return "Basin F35";
        case 176:
          return "Basin F40";
        case 178:
          return "Basin UNIIQ";
        case 172:
          return "Countertop basin";
        case 182:
          return "Mirrors";
        case 181:
          return "Lights";
        case 192:
          return "Sliding";
        case 188:
          return "Shower trays";
        case 203:
          return "Walk-in";
      }
      break;
    case "fr":
      switch (tipo.id) {
        case 170:
          return "Plan vasque ALLIANCE";
        case 169:
          return "Plan vasque MAM";
        case 175:
          return "Vasque F35";
        case 176:
          return "Vasque F40";
        case 178:
          return "Vasque UNIIQ";
        case 172:
          return "Vasque à poser";
        case 182:
          return "Miroirs";
        case 181:
          return "Appliques";
        case 192:
          return "Coulissante  ";
        case 188:
          return "Receveurs de douche";
        case 203:
          return "Ouverte";
      }
      break;
    default:*/
      switch (selectedLanguage) {
        case 'es':
          return gama.title_es;
        case 'en':
          return gama.title_en;
        case 'fr':
          return gama.title_fr;
      }
  
  return gama.nombre;

}
