import 'package:flutter/material.dart';
import 'package:salgar2023/theme/app_theme.dart';
import 'package:salgar2023/widgets/widgets.dart';
import 'package:salgar2023/classes/language.utils.dart';

const Map<String, String> translations = {
  'es': 'VER',
  'en': 'SEE',
  'fr': 'VOIR',
};

const Map<String, Map<String, String>> catalogoTranslations = {
  'CATALOGO GENERAL': {
    'es': 'CATALOGO GENERAL',
    'en': 'CATALOGO GENERAL',
    'fr': 'CATALOGO GENERAL',
  },
  'SUPEROFERTAS': {
    'es': 'SUPEROFERTAS',
    'en': 'SUPEROFERTAS',
    'fr': 'SUPEROFERTAS',
  },
  'MAMPARAS': {
    'es': 'MAMPARAS',
    'en': 'SCREENS',
    'fr': 'PAROIS DE DOUCHE',
  },
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCatalogoNombre = "CATALOGO GENERAL";
  var selectedLanguage = "es";

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
  }

  void updateSelectedCatalogo(String nombre) {
    setState(() {
      selectedCatalogoNombre = nombre;
      print("UPDATE CATALOGO "+nombre);
    });
  }

  void openCatalogo() async {
    final Map<String, String> arguments = selectedCatalogoNombre == "MAMPARAS" ?
    {'catalogoName' : 'CATALOGO GENERAL', 'serieName' : 'MAMPARAS'} :
    {'catalogoName' : selectedCatalogoNombre, 'serieName' : 'no-serie'};

    await Navigator.pushNamed(context, 'showcatalogo', arguments: arguments).then((_) {
      LanguageUtils.getSelectedLanguage().then((language) {
        setState(() {
          selectedLanguage = language ?? "es";
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String seeText = translations[selectedLanguage] ?? "VER";
    String catalogoName = (catalogoTranslations[selectedCatalogoNombre]?[selectedLanguage]) ?? "CATALOGO GENERAL";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'home'),
            child: const Image(
              width: 80,
              image: AssetImage('assets/logo_bar.png'),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Theme(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const Drawer(
        child: MenuWidget(),
      ),
      body: Column(
        children: [
          CardSwiper(
             onCatalogoSelected: openCatalogo,
             onSwipe: updateSelectedCatalogo,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryDark,
                    foregroundColor: AppTheme.primaryLight,
                  ),
                  child: Text('$seeText $catalogoName'),
                  onPressed: () {
                    openCatalogo();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
