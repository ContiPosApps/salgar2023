import 'package:shared_preferences/shared_preferences.dart';

class LanguageUtils {
  static const defaultLanguage = 'es'; // Establece un idioma predeterminado (en caso de que no haya uno seleccionado)

  static Future<String?> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedLanguage") ?? defaultLanguage;
  }

  static void guardarIdiomaSeleccionado(String idioma) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedLanguage", idioma);
  }

    static Future<String> getTranslatedValue(Map<String, String> translations, String key) async {
    String selectedLanguage = await getSelectedLanguage() ?? defaultLanguage;

    if (!translations.containsKey(selectedLanguage)) {
      return translations[defaultLanguage] ?? ''; 
    }

    return translations[selectedLanguage] ?? '';
  }

}

