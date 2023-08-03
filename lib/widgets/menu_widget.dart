import 'package:salgar2023/router/app_routes_menu.dart';
import 'package:salgar2023/theme/app_theme.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:salgar2023/classes/language.utils.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LanguageUtils.getSelectedLanguage(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var leng = snapshot.data!;
          return Scaffold(
            backgroundColor: AppTheme.primaryDark,
            body: ListView.builder(
              itemCount: AppRoutesMenu.getMenuOptionsUrlByLanguage(leng).length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    AppRoutesMenu.getMenuOptionsUrlByLanguage(leng)[index].name,
                    style: const TextStyle(color: AppTheme.primaryLight),
                  ),
                  onTap: () {
                    final url = AppRoutesMenu.getMenuOptionsUrlByLanguage(leng)[index].url;
                    //_launchURL(url);
                    _openInBrowser(url);
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  /*Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
    } else {
        throw 'No se pudo abrir $url';
    }
  }*/

  void _openInBrowser(String url) {
    FlutterWebBrowser.openWebPage(
      url: url,
    );
  }
}
