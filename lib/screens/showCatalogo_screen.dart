import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salgar2023/theme/app_theme.dart';
import 'package:salgar2023/widgets/widgets.dart';
import 'package:salgar2023/classes/classes.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

const Map<String, String> verSerieTranslations = {
  'es': 'VER SERIE',
  'en': 'SEE SERIES',
  'fr': 'VOIR LA SERIE',
};

const Map<String, String> verGamaTranslations = {
  'es': 'VER GAMA',
  'en': 'SEE GAMA',
  'fr': 'VOIR LA GAMME',
};

class ShowCatalogoScreen extends StatefulWidget {
  const ShowCatalogoScreen({Key? key}) : super(key: key);

  @override
  State<ShowCatalogoScreen> createState() => _ShowCatalogoScreenState();
}

class _ShowCatalogoScreenState extends State<ShowCatalogoScreen> {
  List<Gama> showcatalogos = [];
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  var selectedLanguage = "es";
  late Future<Catalogo> catBD;
  late Future<Serie> serieBD;

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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 25 >=
              _scrollController.position.maxScrollExtent &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        if (_isLoadingMore != true) {
          setState(() {
            _isLoadingMore = true;
          });

          DB.soCompleted().then((newGamas) {
            setState(() {
              showcatalogos.addAll(newGamas);
            });
          });
        }
      }
    });
  }

  String selectedSerie = "";
  String selectedGama = "";

  void openGama(Gama gama) {
    setState(() {
      selectedGama = gama.nombre;
    });

    Navigator.pushNamed(
      context,
      'products',
      arguments: {
        'gamaName': selectedGama,
        'gama': gama,
      },
    ).then((_) {
      // Aquí, después de la navegación, volvemos a obtener el idioma seleccionado
      LanguageUtils.getSelectedLanguage().then((language) {
        setState(() {
          selectedLanguage = language ?? "es";
        });
      });
    });
  }

  void openSerie(String nombre) {
    setState(() {
      selectedSerie = nombre;
    });

    Navigator.pushNamed(
      context,
      'showcatalogo',
      arguments: {
        'catalogoName': 'CATALOGO GENERAL',
        'serieName': selectedSerie
      },
    ).then((_) {
      // Aquí, después de la navegación, volvemos a obtener el idioma seleccionado
      LanguageUtils.getSelectedLanguage().then((language) {
        setState(() {
          selectedLanguage = language ?? "es";
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String catalogo = args['catalogoName'].toString();
    final String serieArg = args['serieName'].toString();
    print("$catalogo $serieArg");
    print(serieArg.runtimeType);
    if (catalogo != "null") {
      catBD = _obtenerCatalogo(catalogo);
    }
    if (serieArg != "no-serie") {
      serieBD = _obtenerSerie(serieArg);
    }

    final size = MediaQuery.of(context).size;

    //CATALOGO GENERAL

    if (catalogo == 'CATALOGO GENERAL') {
      //CARGAR TODAS LAS SERIES

      if (serieArg == "no-serie") {
        return FutureBuilder<List<Serie>>(
          future: DB.series(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final series = snapshot.data!;
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
                            catalogo: catalogo,
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final serie = series[index];
                                String serieTitle;
                                switch (selectedLanguage) {
                                  case 'es':
                                    serieTitle = serie.title_es;
                                    break;
                                  case 'en':
                                    serieTitle = serie.title_en;
                                    break;
                                  case 'fr':
                                    serieTitle = serie.title_fr;
                                    break;
                                  default:
                                    serieTitle = serie
                                        .title_es; // Default to 'es' if language is not recognized
                                }
                                return SizedBox(
                                  width: size.width,
                                  child: GestureDetector(
                                    onTap: () {
                                      openSerie(serie.nombre);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          child: Column(
                                            children: [
                                              Image(
                                                image: AssetImage(serie.img),
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          child: Container(
                                            color: AppTheme.primaryLight,
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextButton(
                                              onPressed: () {
                                                openSerie(serie.nombre);
                                              },
                                              child: Text(
                                                '${verSerieTranslations[selectedLanguage]} ${serieTitle}',
                                                style: const TextStyle(
                                                  color: AppTheme.primaryDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: series.length,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                          padding: const EdgeInsets.all(16),
                          child: FloatingActionButton(
                            onPressed: () async {
                              if (catalogo != null) {
                                Catalogo ct = await catBD;
                                final url = _getUrlForLanguageCatalogo(
                                    ct, selectedLanguage);
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
                    ]
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
        //CARGAR SERIE ESPECIFICA

        return FutureBuilder<List<Gama>>(
          future: DB.gamasSeries(serieArg),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final gamas = snapshot.data!;
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
                            catalogo: catalogo,
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final gama = gamas[index];
                                String gamaTitle; // Define the title variable
                                switch (selectedLanguage) {
                                  case 'es':
                                    gamaTitle = gama.title_es;
                                    break;
                                  case 'en':
                                    gamaTitle = gama.title_en;
                                    break;
                                  case 'fr':
                                    gamaTitle = gama.title_fr;
                                    break;
                                  default:
                                    gamaTitle = gama
                                        .title_es; // Default to 'es' if language is not recognized
                                }
                                return SizedBox(
                                  width: size.width,
                                  child: GestureDetector(
                                    onTap: () {
                                      openGama(gama);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          child: Column(
                                            children: [
                                              Image(
                                                image: AssetImage(gama.img),
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          child: Container(
                                            color: AppTheme.primaryLight,
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextButton(
                                              onPressed: () {
                                                openGama(gama);
                                              },
                                              child: Text(
                                                "${verGamaTranslations[selectedLanguage]} ${gamaTitle}", // Use gamaTitle instead of gama.nombre
                                                style: const TextStyle(
                                                  color: AppTheme.primaryDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: gamas.length,
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
                              if (serieBD != null) {
                                Serie serie1 = await serieBD;
                                final url =
                                    _getUrlFromSerie(serie1, selectedLanguage);
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
                    ]
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
      //SUPEROFERTAS

      if (_isLoadingMore != true) {
        return FutureBuilder<List<Gama>>(
          future: DB.soMain(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              showcatalogos = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Scaffold(
                  drawer: const Drawer(
                    child: MenuWidget(),
                  ),
                  body: Stack(
                    children: <Widget>[
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          _CustomAppBar(
                            catalogo: catalogo,
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final showcatalogo = showcatalogos[index];
                                String gamaTitle; // Define the title variable
                                switch (selectedLanguage) {
                                  case 'es':
                                    gamaTitle = showcatalogo.title_es;
                                    break;
                                  case 'en':
                                    gamaTitle = showcatalogo.title_en;
                                    break;
                                  case 'fr':
                                    gamaTitle = showcatalogo.title_fr;
                                    break;
                                  default:
                                    gamaTitle = showcatalogo
                                        .title_es; // Default to 'es' if language is not recognized
                                }
                                return SizedBox(
                                  width: size.width,
                                  child: GestureDetector(
                                    onTap: () {
                                      openGama(showcatalogo);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          child: Column(
                                            children: [
                                              Image(
                                                image: AssetImage(showcatalogo.img),
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          child: Container(
                                            color: AppTheme.primaryLight,
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextButton(
                                              onPressed: () {
                                                openGama(showcatalogo);
                                              },
                                              child: Text(
                                                '${verGamaTranslations[selectedLanguage]} ${gamaTitle}', // Use gamaTitle instead of showcatalogo.nombre
                                                style: const TextStyle(
                                                  color: AppTheme.primaryDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: showcatalogos.length,
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
                              if (catalogo != null) {
                                Catalogo ct = await catBD;
                                final url =
                                    _getUrlForLanguageCatalogo(ct, selectedLanguage);
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
                    ]
                  ),
                  //CARGAR GAMAS superofertas
                   
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
        return FutureBuilder<List<Gama>>(
          future: Future.value(showcatalogos),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              showcatalogos = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Scaffold(
                  drawer: const Drawer(
                    child: MenuWidget(),
                  ),
                  body: Stack(
                    children: <Widget>[
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          _CustomAppBar(
                            catalogo: catalogo,
                            selectedLanguage: selectedLanguage,
                            onLanguageChanged: onLanguageChanged,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final showcatalogo = showcatalogos[index];
                                String gamaTitle; // Define the title variable
                                switch (selectedLanguage) {
                                  case 'es':
                                    gamaTitle = showcatalogo.title_es;
                                    break;
                                  case 'en':
                                    gamaTitle = showcatalogo.title_en;
                                    break;
                                  case 'fr':
                                    gamaTitle = showcatalogo.title_fr;
                                    break;
                                  default:
                                    gamaTitle = showcatalogo
                                        .title_es; // Default to 'es' if language is not recognized
                                }
                                return SizedBox(
                                  width: size.width,
                                  child: GestureDetector(
                                    onTap: () {
                                      openGama(showcatalogo);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          child: Column(
                                            children: [
                                              Image(
                                                image: AssetImage(showcatalogo.img),
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          child: Container(
                                            color: AppTheme.primaryLight,
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextButton(
                                              onPressed: () {
                                                openGama(showcatalogo);
                                              },
                                              child: Text(
                                                '${verGamaTranslations[selectedLanguage]} ${gamaTitle}', // Use gamaTitle instead of showcatalogo.nombre
                                                style: const TextStyle(
                                                  color: AppTheme.primaryDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: showcatalogos.length,
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
                              if (catalogo != null) {
                                Catalogo ct = await catBD;
                                final url =
                                    _getUrlForLanguageCatalogo(ct, selectedLanguage);
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
                    ]
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
    }
  }
}

class _CustomAppBar extends StatelessWidget {
  final String catalogo;
  final String selectedLanguage;
  final void Function(String?)? onLanguageChanged;

  const _CustomAppBar({
    Key? key,
    required this.catalogo,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(catalogo),
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
    );
  }
}

String? _getUrlForLanguageCatalogo(Catalogo url, String language) {
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

String? _getUrlFromSerie(Serie url, String language) {
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

Future<Catalogo> _obtenerCatalogo(String nombre) async {
  return await DB.cargarCatalogoPorNombre(nombre);
}

Future<Serie> _obtenerSerie(String nombre) async {
  return await DB.cargarSeriePorNombre(nombre);
}
