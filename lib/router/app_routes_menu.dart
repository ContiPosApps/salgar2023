import 'package:salgar2023/models/models.dart';

class AppRoutesMenu {
  static const initialRoute = 'animation_home';
  

  static final List<MenuOptionUrl> menuOptionsUrlES = [
    MenuOptionUrl(
      route: 'home',
      name: 'Catálogos',
      url: "https://www.salgar.net/es/catalogos-salgar",
    ),
    MenuOptionUrl(
      route: 'showroom',
      name: 'Showroom',
      url: "https://my.matterport.com/show/?m=nnH8asG6wVf",
    ),
    MenuOptionUrl(
      route: 'quienessomos',
      name: '¿Quiénes somos?',
      url: "https://www.salgar.net/es/fabricante-muebles-de-bano",
    ),
    MenuOptionUrl(
      route: 'materialesyacabados',
      name: 'Materiales y Acabados',
      url: "https://www.salgar.net/es/materiales-y-acabados",
    ),
    MenuOptionUrl(
      route: 'contacto',
      name: 'Contacto',
      url: "https://soporte.salgar.net/hc/es/requests/new?ticket_form_id=5056564400657",
    ),
  ];

  static final List<MenuOptionUrl> menuOptionsUrlEN = [
    MenuOptionUrl(
      route: 'home',
      name: 'Catalogues',
      url: "https://www.salgar.net/en/salgar-catalogues-uk",
    ),
    MenuOptionUrl(
      route: 'showroom',
      name: 'Showroom',
      url: "https://my.matterport.com/show/?m=FMSZmrhV6Rn",
    ),
    MenuOptionUrl(
      route: 'quienessomos',
      name: 'Who we are',
      url: "https://www.salgar.net/en/company-salgar",
    ),
    MenuOptionUrl(
      route: 'materialesyacabados',
      name: 'Materials and finishes',
      url: "https://www.salgar.net/en/materials-finishes",
    ),
    MenuOptionUrl(
      route: 'contacto',
      name: 'Contact',
      url: "https://soporte.salgar.net/hc/en-gb/requests/new?ticket_form_id=5056564400657",
    ),
  ];

  static final List<MenuOptionUrl> menuOptionsUrlFR = [
    MenuOptionUrl(
      route: 'home',
      name: 'Catalogues',
      url: "https://www.salgar.net/fr/catalogues-salgar-fr",
    ),
    MenuOptionUrl(
      route: 'showroom',
      name: 'Showroom',
      url: "https://my.matterport.com/show/?m=EUeVAuLFFst",
    ),
    MenuOptionUrl(
      route: 'quienessomos',
      name: 'Qui sommes nous',
      url: "https://www.salgar.net/fr/societe-salgar",
    ),
    MenuOptionUrl(
      route: 'materialesyacabados',
      name: 'Matériaux et finitions',
      url: "https://www.salgar.net/fr/materiaux-finitions<",
    ),
    MenuOptionUrl(
      route: 'contacto',
      name: 'Contact',
      url: "https://soporte.salgar.net/hc/fr/requests/new?ticket_form_id=5056564400657",
    ),
  ];

  static List<MenuOptionUrl> getMenuOptionsUrlByLanguage(String languageCode) {
    if (languageCode == 'en') {
      return menuOptionsUrlEN;
    } else if (languageCode == 'fr') {
      return menuOptionsUrlFR;
    } else {
      return menuOptionsUrlES;
    }
  }
}
