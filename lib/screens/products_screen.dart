import 'package:flutter/material.dart';
import 'package:salgar2023/theme/app_theme.dart';
import 'package:salgar2023/widgets/widgets.dart';
import 'package:salgar2023/classes/classes.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int subTipoId = 0;
  int? idSubTipoReal;
  var selectedLanguage = "es";
  bool isOpen = false;
  bool cargado = false;
  late Gama gama;
  late TipoProducto? tipoEnviar;

  void onLanguageChanged(String? newValue) {
    setState(() {
      selectedLanguage = newValue ?? "es";
    });
    LanguageUtils.guardarIdiomaSeleccionado(selectedLanguage);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String gamaArg = args['gamaName'].toString();
      gama = args['gama'];
      DB.tipos(gamaArg).then((tipos) {
        for (final tipo in tipos) {
          if (!isOpen) {
            if (tipo.id == 201 ||
                tipo.id == 188 ||
                tipo.id == 203 ||
                tipo.id == 202) {
              isOpen = true;
              Navigator.pushNamed(
                context,
                'imgProducto',
                arguments: {
                  'idTipo': tipo.id,
                  'idSubTipo': idSubTipoReal,
                  'idUrl': tipo.url,
                  'tipo': tipo,
                  'gamaName': gamaArg,
                  'gama': gama,
                },
              ).then((_) {
                // Aquí, después de la navegación, volvemos a obtener el idioma seleccionado
                LanguageUtils.getSelectedLanguage().then((language) {
                  if (mounted) {
                    // Verifica si el widget está todavía en el árbol de widgets
                    setState(() {
                      selectedLanguage = language ?? "es";
                    });
                    Navigator.of(context).pop();
                  }
                });
              });
              return;
            }
          } else {}
        }
        setState(() {});
      });
      cargado = true;
      setState(() {});
    });

    LanguageUtils.getSelectedLanguage().then((language) {
      setState(() {
        selectedLanguage = language ?? "es";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String gamaArg = args['gamaName'].toString();
    print(gamaArg);

    final size = MediaQuery.of(context).size;
    if (cargado) {
      if (subTipoId == 0) {
        return FutureBuilder<List<TipoProducto>>(
          future: DB.tipos(gamaArg),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tipos = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Scaffold(
                  drawer: const Drawer(
                    child: MenuWidget(),
                  ),
                  body: Stack(
                    children: <Widget>[
                      CustomScrollView(
                        slivers: [
                          _CustomAppBar(
                            title: _getNameForLanguage(gama, selectedLanguage),
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final tipo = tipos[index];
                                return GestureDetector(
                                  onTap: () async {
                                    List<subTipo> subtypes =
                                        await DB.subTipos(tipo.id);
                                    if (subtypes.isEmpty) {
                                      Navigator.pushNamed(
                                        context,
                                        'imgProducto',
                                        arguments: {
                                          'idTipo': tipo.id,
                                          'idSubTipo': idSubTipoReal,
                                          'idUrl': tipo.url,
                                          'tipo': tipo,
                                          'gamaName': gamaArg,
                                          'gama': gama,
                                        },
                                      ).then((_) {
                                        // Aquí, después de la navegación, volvemos a obtener el idioma seleccionado
                                        LanguageUtils.getSelectedLanguage()
                                            .then((language) {
                                          if (mounted) {
                                            // Verifica si el widget está todavía en el árbol de widgets
                                            setState(() {
                                              selectedLanguage =
                                                  language ?? "es";
                                            });
                                          }
                                        });
                                      });
                                    } else {
                                      tipoEnviar = tipo;
                                      subTipoId = tipo.id;
                                      setState(() {});
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        child: Column(
                                          children: [
                                            Image(
                                              image: AssetImage(tipo.img),
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 6,
                                        child: Container(
                                          color: AppTheme.primaryLight,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              _devolverNombreIdioma(tipo,
                                                  selectedLanguage, gamaArg),
                                              style: const TextStyle(
                                                color: AppTheme.primaryDark,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: tipos.length,
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
                              if (Gama != null) {
                                final url =
                                    _getUrlForLanguage(gama, selectedLanguage);
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
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Error al cargar los catálogos'),
                ),
              );
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      } else {
        return FutureBuilder<List<subTipo>>(
          future: DB.subTipos(subTipoId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tipos = snapshot.data!;

              return SizedBox(
                width: double.infinity,
                child: Scaffold(
                  drawer: const Drawer(
                    child: MenuWidget(),
                  ),
                  body: Stack(
                    children: <Widget>[
                      CustomScrollView(
                        slivers: [
                          _CustomAppBar(
                            title: _getNameForLanguage(gama, selectedLanguage),
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final tipo = tipos[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      'imgProducto',
                                      arguments: {
                                        'idTipo': tipo.idTipo,
                                        'idSubTipo': tipo.id,
                                        'idUrl': tipo.url,
                                        'tipo': tipoEnviar,
                                        'gamaName': gamaArg,
                                        'gama': gama,
                                      },
                                    ).then((_) {
                                      // Aquí, después de la navegación, volvemos a obtener el idioma seleccionado
                                      LanguageUtils.getSelectedLanguage()
                                          .then((language) {
                                        if (mounted) {
                                          // Verifica si el widget está todavía en el árbol de widgets
                                          setState(() {
                                            selectedLanguage = language ?? "es";
                                          });
                                        }
                                      });
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        child: Column(
                                          children: [
                                            Image(
                                              image: AssetImage(tipo.img),
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 6,
                                        child: Container(
                                          color: AppTheme.primaryLight,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              tipo.nombre,
                                              style: const TextStyle(
                                                color: AppTheme.primaryDark,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: tipos.length,
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
                              subTipoId = 0;
                              setState(() {});
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
                              if (gama != null) {
                                final url =
                                    _getUrlForLanguage(gama, selectedLanguage);
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
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Error al cargar los catálogos'),
                ),
              );
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }
    } else {
      return Container();
    }
  }
}

class _CustomAppBar extends StatelessWidget {
  final String? title;
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
                  child: Text(title!),
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

String _devolverNombreIdioma(
    TipoProducto tipo, String selectedLanguage, String gama) {
  print("entra en devolver idioma");
  switch (selectedLanguage) {
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
        case 188:
          return "Platos";
        case 203:
          return "De paso y fijas";
      }
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
        case 188:
          return "Shower trays";
        case 203:
          return "Walk-in";
      }
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
        case 188:
          return "Receveurs de douche";
        case 203:
          return "Ouverte";
      }
  }
  return tipo.nombre;
}

String? _getUrlForLanguage(Gama url, String language) {
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

String? _getNameForLanguage(Gama gama, String? language) {
  switch (language) {
    case 'es':
      return gama.title_es;
    case 'en':
      return gama.title_en;
    case 'fr':
      return gama.title_fr;
    default:
      return gama.nombre;
  }
}
