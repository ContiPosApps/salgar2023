import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salgar2023/classes/classes.dart';

class DB {
  static Future<Database> _openDB() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path,
        'salgar2023.db'); // Nombre del archivo de la base de datos

    final database = openDatabase(join(await getDatabasesPath(), dbPath),
        onCreate: (db, version) {
      // Crea la tabla "catalogos" con los campos definidos
      db.execute(
          "CREATE TABLE catalogos (id INTEGER PRIMARY KEY, nombre TEXT, img TEXT, title_es TEXT, title_en TEXT, title_fr TEXT, url_es TEXT, url_en TEXT, url_fr TEXT);");

      // Inserta los datos iniciales
      db.insert(
        'catalogos',
        {
          'id': 1,
          'nombre': 'CATALOGO GENERAL',
          'img': 'assets/cg_portada.jpg',
          'title_es': 'CATALOGO GENERAL',
          'title_en': 'CATALOGO GENERAL',
          'title_fr': 'CATALOGO GENERAL',
          'url_es': 'https://www.salgar.net/es/catalogos-salgar',
          'url_en': 'https://www.salgar.net/en/salgar-catalogues-uk',
          'url_fr': 'https://www.salgar.net/en//catalogues-salgar-fr',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.insert(
        'catalogos',
        {
          'id': 2,
          'nombre': 'SUPEROFERTAS',
          'img': 'assets/so_portada.jpg',
          'title_es': 'SUPEROFERTAS',
          'title_en': 'SUPEROFERTAS',
          'title_fr': 'SUPEROFERTAS',
          'url_es': 'https://www.salgar.net/es/conjuntos-muebles-baño',
          'url_en': 'https://www.salgar.net/en/sets',
          'url_fr': 'https://www.salgar.net/fr/ensembles',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.insert(
        'catalogos',
        {
          'id': 3,
          'nombre': 'MAMPARAS',
          'img': 'assets/series_mamparas_portada.jpg',
          'title_es': 'MAMPARAS',
          'title_en': 'SCREENS',
          'title_fr': 'PAROIS DE DOUCHE',
          'url_es': 'https://www.salgar.net/es/espacio-mampara-2023',
          'url_en': 'https://www.salgar.net/en/espacio-mampara-en',
          'url_fr': 'https://www.salgar.net/fr/monde-douche-salgar-2023',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      //Crear tabla series con sus datos iniciales
      db.execute(
          "CREATE TABLE series (id INTEGER PRIMARY KEY,idCatalogo INTEGER,nombre TEXT,img TEXT, title_es TEXT, title_en TEXT, title_fr TEXT, url_es TEXT, url_en TEXT, url_fr TEXT ,FOREIGN KEY (idCatalogo) REFERENCES catalogos (id) ON DELETE NO ACTION ON UPDATE NO ACTION);");

      db.insert('series', {
        'id': 1,
        'idCatalogo': 1,
        'nombre': 'ORIGINAL',
        'img': 'assets/series_or_portada.jpg',
        'title_es': 'ORIGINAL',
        'title_en': 'ORIGINAL',
        'title_fr': 'ORIGINAL',
        'url_es': 'https://www.salgar.net/es/series-original-salgar',
        'url_en': 'https://www.salgar.net/en/series-original-salgar-en',
        'url_fr': 'https://www.salgar.net/fr/serie-originale-salgar',
      });

      db.insert('series', {
        'id': 2,
        'idCatalogo': 1,
        'nombre': 'MODULAR',
        'img': 'assets/series_mo_portada.jpg',
        'title_es': 'MODULAR',
        'title_en': 'MODULAR',
        'title_fr': 'MODULAR',
        'url_es': 'https://www.salgar.net/es/series-modulares-salgar',
        'url_en': 'https://www.salgar.net/en/modular-salgar',
        'url_fr': 'https://www.salgar.net/fr/serie-modulaire-salgar',
      });

      db.insert('series', {
        'id': 3,
        'idCatalogo': 1,
        'nombre': 'LAVABOS',
        'img': 'assets/series_lavabos_portada.jpg',
        'title_es': 'LAVABOS',
        'title_en': 'WASHBASIN',
        'title_fr': 'VASQUES',
        'url_es': 'https://www.salgar.net/es/lavabos-integrados',
        'url_en': 'https://www.salgar.net/en/integrated-washbasins',
        'url_fr': 'https://www.salgar.net/fr/lavabos-integres',
      });

      db.insert('series', {
        'id': 4,
        'idCatalogo': 1,
        'nombre': 'MAMPARAS',
        'img': 'assets/series_mamparas_portada.jpg',
        'title_es': 'MAMPARAS',
        'title_en': 'SCREENS',
        'title_fr': 'PAROIS DE DOUCHE',
        'url_es': 'https://www.salgar.net/es/espacio-mampara-2023',
        'url_en': 'https://www.salgar.net/en/espacio-mampara-en',
        'url_fr': 'https://www.salgar.net/fr/monde-douche-salgar-2023',
      });

      //Crear tabla showcatalogo con sus datos iniciales
      db.execute('CREATE TABLE gama ('
          'id INTEGER PRIMARY KEY, '
          'idCatalogo INTEGER, '
          'idSerie INTEGER NULL, ' // Permitir valores nulos en idSerie
          'nombre TEXT, '
          'img TEXT, '
          'title_es TEXT,'
          'title_en TEXT, '
          ' title_fr TEXT, '
          'url_es TEXT, '
          ' url_en TEXT, '
          ' url_fr TEXT,'
          'FOREIGN KEY (idCatalogo) REFERENCES catalogos (id) ON DELETE NO ACTION ON UPDATE NO ACTION, '
          'FOREIGN KEY (idSerie) REFERENCES series (id) ON DELETE NO ACTION ON UPDATE NO ACTION'
          ');');

      //GAMAS SUPEROFERTAS

      db.insert('gama', {
        'id': 1,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'OPTIMUS',
        'img': 'assets/so_gama_optimus_portada.jpg',
        'title_es': 'OPTIMUS',
        'title_en': 'OPTIMUS',
        'title_fr': 'OPTIMUS',
        'url_es': 'https://www.salgar.net/es/optimus-6822',
        'url_en': 'https://www.salgar.net/en/optimus-4616',
        'url_fr': 'https://www.salgar.net/fr/optimus-5664',
      });

      db.insert('gama', {
        'id': 2,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'ATTILA',
        'img': 'assets/so_gama_attila_portada.jpg',
        'title_es': 'ATTILA',
        'title_en': 'ATTILA',
        'title_fr': 'ATTILA',
        'url_es': 'https://www.salgar.net/es/serie-attila',
        'url_en': 'https://www.salgar.net/en/attila-7826',
        'url_fr': 'https://www.salgar.net/fr/attila-1619',
      });

      db.insert('gama', {
        'id': 3,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'NOJA',
        'img': 'assets/so_gama_noja_portada.jpg',
        'title_es': 'NOJA',
        'title_en': 'NOJA',
        'title_fr': 'NOJA',
        'url_es': 'https://www.salgar.net/es/conjunto-completo-noja',
        'url_en': 'https://www.salgar.net/en/complet-set-noja',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-noja',
      });

      db.insert('gama', {
        'id': 4,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'ARENYS',
        'img': 'assets/so_gama_arenys_portada.jpg',
        'title_es': 'ARENYS',
        'title_en': 'ARENYS',
        'title_fr': 'ARENYS',
        'url_es': 'https://www.salgar.net/es/conjunto-completo-arenys',
        'url_en': 'https://www.salgar.net/en/complet-set-arenys',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-arenys',
      });

      db.insert('gama', {
        'id': 5,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'ALMAGRO',
        'img': 'assets/so_gama_almagro_portada.jpg',
        'title_es': 'ARENYS',
        'title_en': 'ARENYS',
        'title_fr': 'ARENYS',
        'url_es': 'https://www.salgar.net/es/conjunto-completo-arenys',
        'url_en': 'https://www.salgar.net/en/complet-set-arenys',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-arenys',
      });

      db.insert('gama', {
        'id': 6,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'MICRO',
        'img': 'assets/so_gama_micro_portada.jpg',
        'title_es': 'MICRO',
        'title_en': 'MICRO',
        'title_fr': 'MICRO',
        'url_es': 'https://www.salgar.net/es/conjunto-completo-micro',
        'url_en': 'https://www.salgar.net/en/complet-set-micro',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-micro',
      });

      db.insert('gama', {
        'id': 7,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'PMR',
        'img': 'assets/so_gama_pmr_portada.jpg',
        'title_es': 'PMR',
        'title_en': 'PMR',
        'title_fr': 'PMR',
        'url_es': 'https://www.salgar.net/es/personas-movilidad-reducida',
        'url_en': 'https://www.salgar.net/en/people-reduced-mobility',
        'url_fr': 'https://www.salgar.net/fr/personnes-mobilite-reduite',
      });

      db.insert('gama', {
        'id': 8,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'ESPEJOS',
        'img': 'assets/so_gama_espejos_portada.jpg',
        'title_es': 'ESPEJOS',
        'title_en': 'MIRRORS',
        'title_fr': 'MIROIRS',
        'url_es': 'https://www.salgar.net/es/espejos-sunset',
        'url_en': 'https://www.salgar.net/en/mirrors-sunset',
        'url_fr': 'https://www.salgar.net/fr/miroirs-sunset',
      });

      db.insert('gama', {
        'id': 9,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'PANELES',
        'img': 'assets/so_gama_paneles_portada.jpg',
        'title_es': 'PANELES',
        'title_en': 'BATH PANEL',
        'title_fr': 'BATH PANEL',
        'url_es': 'https://www.salgar.net/es/panel-de-ducha-684-gris-mate',
        'url_en': 'https://www.salgar.net/en/bath-panel-684-matt-grey',
        'url_fr': 'https://www.salgar.net/fr/bath-panel-684-gris-mat',
      });

      db.insert('gama', {
        'id': 10,
        'idCatalogo': 2,
        'idSerie': null,
        'nombre': 'INFINITY',
        'img': 'assets/so_gama_infinity_portada.jpg',
        'title_es': 'INFINITY',
        'title_en': 'INFINITY',
        'title_fr': 'INFINITY',
        'url_es':
            'https://www.salgar.net/search?searchCriteria=infinity&customTagsSearchList=&searchproducts=true&searchcategories=-1&searchblog=-1&searchpages=-1&searchnews=-1&minCharacters=3',
        'url_en':
            'https://www.salgar.net/search?searchCriteria=infinity&customTagsSearchList=&searchproducts=true&searchcategories=-1&searchblog=-1&searchpages=-1&searchnews=-1&minCharacters=3',
        'url_fr':
            'https://www.salgar.net/search?searchCriteria=infinity&customTagsSearchList=&searchproducts=true&searchcategories=-1&searchblog=-1&searchpages=-1&searchnews=-1&minCharacters=3',
      });

      //GAMAS ORIGINALS

      // GAMAS BAÑO
      db.insert('gama', {
        'id': 12,
        'idCatalogo': 1,
        'idSerie': 1,
        'nombre': 'MOMENT',
        'img': 'assets/serie_gama_or_moment_portada.jpg',
        'title_es': 'MOMENT',
        'title_en': 'MOMENT',
        'title_fr': 'MOMENT',
        'url_es': 'https://www.salgar.net/es/muebles-de-bano-moment',
        'url_en': 'https://www.salgar.net/en/muebles-de-bano-moment',
        'url_fr': 'https://www.salgar.net/fr/meubles-salle-bain-moment',
      });

      db.insert('gama', {
        'id': 13,
        'idCatalogo': 1,
        'idSerie': 1,
        'nombre': 'RENOIR',
        'img': 'assets/serie_gama_or_renoir_portada.jpg',
        'title_es': 'RENOIR',
        'title_en': 'RENOIR',
        'title_fr': 'RENOIR',
        'url_es': 'https://www.salgar.net/es/muebles-bano-renoir',
        'url_en': 'https://www.salgar.net/en/renoir-en',
        'url_fr': 'https://www.salgar.net/fr/meubles-salle-bain-renoir',
      });

      db.insert('gama', {
        'id': 14,
        'idCatalogo': 1,
        'idSerie': 1,
        'nombre': 'MAM',
        'img': 'assets/serie_gama_or_mam_portada.jpg',
        'title_es': 'MAM',
        'title_en': 'MAM',
        'title_fr': 'MAM',
        'url_es': 'https://www.salgar.net/es/muebles-mam-bano',
        'url_en': 'https://www.salgar.net/en/mam-2109',
        'url_fr': 'https://www.salgar.net/fr/mam-meubles-salle-bain',
      });

      db.insert('gama', {
        'id': 15,
        'idCatalogo': 1,
        'idSerie': 1,
        'nombre': 'UNIIQ',
        'img': 'assets/serie_gama_or_uniiq_portada.jpg',
        'title_es': 'UNIIQ',
        'title_en': 'UNIIQ',
        'title_fr': 'UNIIQ',
        'url_es': 'https://www.salgar.net/es/mueble-bano-uniiq',
        'url_en': 'https://www.salgar.net/en/uniiq-en',
        'url_fr': 'https://www.salgar.net/fr/meuble-salle-bain-uniiq',
      });

      db.insert('gama', {
        'id': 16,
        'idCatalogo': 1,
        'idSerie': 1,
        'nombre': 'COMPAKT',
        'img': 'assets/serie_gama_or_compakt_portada.jpg',
        'title_es': 'COMPAKT',
        'title_en': 'COMPAKT',
        'title_fr': 'COMPAKT',
        'url_es': 'https://www.salgar.net/es/compakt-es',
        'url_en': 'https://www.salgar.net/fr/compakt-fr',
        'url_fr': 'https://www.salgar.net/en/compakt-fr',
      });

// GAMAS MODULAR
      db.insert('gama', {
        'id': 17,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'A MEDIDA',
        'img': 'assets/serie_gama_mo_medida_portada.jpg',
        'title_es': 'SOLUCIONES A MEDIDA',
        'title_en': 'TAILOR-MADE SOLUTIONS',
        'title_fr': 'SOLUTIONS SUR MESURE',
        'url_es': 'https://www.salgar.net/es/a-medida',
        'url_en': 'https://www.salgar.net/en/a-medida',
        'url_fr': 'https://www.salgar.net/fr/a-medida',
      });

      db.insert('gama', {
        'id': 18,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'MONTERREY',
        'img': 'assets/serie_gama_mo_monterrey_portada.jpg',
        'title_es': 'MONTERREY',
        'title_en': 'MONTERREY',
        'title_fr': 'MONTERREY',
        'url_es': 'https://www.salgar.net/es/mueble-ba%C3%B1o-monterrey-es',
        'url_en': 'https://www.salgar.net/en/monterrey-en',
        'url_fr': 'https://www.salgar.net/fr/meuble-salle-bain-monterrey',
      });

      db.insert('gama', {
        'id': 19,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'SPIRIT',
        'img': 'assets/serie_gama_mo_spirit_portada.jpg',
        'title_es': 'SPIRIT',
        'title_en': 'SPIRIT',
        'title_fr': 'SPIRIT',
        'url_es': 'https://www.salgar.net/es/mueble-bano-spirit',
        'url_en': 'https://www.salgar.net/en/spirit-en',
        'url_fr': 'https://www.salgar.net/fr/meuble-salle-bain-spirit',
      });

      db.insert('gama', {
        'id': 20,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'FUSSION LINE',
        'img': 'assets/serie_gama_mo_fussion_portada.jpg',
        'title_es': 'FUSSION LINE',
        'title_en': 'FUSSION LINE',
        'title_fr': 'FUSSION LINE',
        'url_es': 'https://www.salgar.net/es/mueble-bano-fussion-line',
        'url_en': 'https://www.salgar.net/en/fussion-line-en',
        'url_fr':
            'https://www.salgar.net/fr/meubles-salle-bain-fussion-line-fr',
      });

      db.insert('gama', {
        'id': 21,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'REDUCIDO',
        'img': 'assets/serie_gama_mo_reducido_portada.jpg',
        'title_es': 'REDUCIDO',
        'title_en': 'REDUCIDO',
        'title_fr': 'REDUCIDO',
        'url_es': 'https://www.salgar.net/es/muebles-bano-reducidos',
        'url_en': 'https://www.salgar.net/en/muebles-bano-reducidos',
        'url_fr': 'https://www.salgar.net/fr/meubles-salle-bain-reducidos',
      });

      db.insert('gama', {
        'id': 22,
        'idCatalogo': 1,
        'idSerie': 2,
        'nombre': 'AUXILIARES',
        'img': 'assets/serie_gama_mo_auxiliares_portada.jpg',
        'title_es': 'AUXILIARES',
        'title_en': 'AUXILIARY',
        'title_fr': 'AUXILIARIRES',
        'url_es': 'https://www.salgar.net/es/muebles-bano-auxiliares',
        'url_en': 'https://www.salgar.net/en/muebles-bano-auxiliares',
        'url_fr': 'https://www.salgar.net/fr/meubles-salle-bain-auxiliares',
      });

// GAMAS LAVABOS
      db.insert('gama', {
        'id': 23,
        'idCatalogo': 1,
        'idSerie': 3,
        'nombre': 'LAVABOS',
        'img': 'assets/serie_gama_lavabos_lavabo_portada.jpg',
        'title_es': 'LAVABOS',
        'title_en': 'WASHBASIN',
        'title_fr': 'VASQUES',
        'url_es': 'https://www.salgar.net/es/lavabos',
        'url_en': 'https://www.salgar.net/en/lavabos',
        'url_fr': 'https://www.salgar.net/fr/lavabos',
      });

      db.insert('gama', {
        'id': 24,
        'idCatalogo': 1,
        'idSerie': 3,
        'nombre': 'ESPEJOS Y APLIQUES',
        'img': 'assets/serie_gama_lavabos_espejosyapliques_portada.jpg',
        'title_es': 'ESPEJOS',
        'title_en': 'MIRRORS',
        'title_fr': 'MIROIRS',
        'url_es': 'https://www.salgar.net/es/espejos-y-apliques',
        'url_en': 'https://www.salgar.net/en/espejos-y-apliques',
        'url_fr': 'https://www.salgar.net/fr/espejos-y-apliques',
      });

      db.insert('gama', {
        'id': 25,
        'idCatalogo': 1,
        'idSerie': 3,
        'nombre': 'ACCESORIOS',
        'img': 'assets/serie_gama_lavabos_espejoyaccesorios_portada.jpg',
        'title_es': 'ACCESORIOS',
        'title_en': 'ACCESSORIES',
        'title_fr': 'ACCESSOIRES',
        'url_es': 'https://www.salgar.net/es/accesorios',
        'url_en': 'https://www.salgar.net/en/accesorios',
        'url_fr': 'https://www.salgar.net/fr/accesorios',
      });

// GAMAS MAMPARAS
      db.insert('gama', {
        'id': 26,
        'idCatalogo': 1,
        'idSerie': 4,
        'nombre': 'PLATOS DE DUCHA',
        'img': 'assets/serie_gama_mamparas_universoducha_portada.jpg',
        'title_es': 'PLATOS DE DUCHA',
        'title_en': 'SHOWER TRAYS',
        'title_fr': 'RECEVEURS DE DOUCHE',
        'url_es': 'https://www.salgar.net/es/platos-de-ducha',
        'url_en': 'https://www.salgar.net/en/platos-de-ducha',
        'url_fr': 'https://www.salgar.net/fr/platos-de-ducha',
      });

      db.insert('gama', {
        'id': 27,
        'idCatalogo': 1,
        'idSerie': 4,
        'nombre': 'DE PASO Y FIJAS',
        'img': 'assets/serie_gama_mamparas_pasosyfijos_portada.jpg',
        'title_es': 'DE PASO Y FIJAS',
        'title_en': 'WALK-IN',
        'title_fr': 'OUVERTE',
        'url_es': 'https://www.salgar.net/es/mamparas-de-paso-y-fijas',
        'url_en': 'https://www.salgar.net/en/mamparas-de-paso-y-fijas',
        'url_fr': 'https://www.salgar.net/fr/mamparas-de-paso-y-fijas',
      });

      db.insert('gama', {
        'id': 28,
        'idCatalogo': 1,
        'idSerie': 4,
        'nombre': 'PUERTAS CORREDERAS',
        'img': 'assets/serie_gama_mamparas_puertascorrederas_portada.jpg',
        'title_es': 'PUERTAS CORREDERAS',
        'title_en': 'SLIDING',
        'title_fr': 'COULISSANTE',
        'url_es': 'https://www.salgar.net/es/puertas-correderas',
        'url_en': 'https://www.salgar.net/en/puertas-correderas',
        'url_fr': 'https://www.salgar.net/fr/puertas-correderas',
      });

      db.insert('gama', {
        'id': 29,
        'idCatalogo': 1,
        'idSerie': 4,
        'nombre': 'PUERTAS ABATIBLES',
        'img': 'assets/serie_gama_mamparas_abatibles_portada.jpg',
        'title_es': 'PUERTAS ABATIBLES',
        'title_en': 'HINGE DOORS',
        'title_fr': 'CHARNIÈRE',
        'url_es': 'https://www.salgar.net/es/mamparas-abatibles',
        'url_en': 'https://www.salgar.net/en/mamparas-abatibles',
        'url_fr': 'https://www.salgar.net/fr/mamparas-abatibles',
      });

      //Crear tabla estampado con sus datos iniciales

      db.execute('CREATE TABLE estampado ('
          'id INTEGER PRIMARY KEY, '
          'img TEXT'
          ');');

      db.insert('estampado', {
        'id': 2,
        'img': 'assets/alsacia.jpg',
      });
      db.insert('estampado', {
        'id': 3,
        'img': 'assets/antracita.jpg',
      });
      db.insert('estampado', {
        'id': 4,
        'img': 'assets/azulaltamar.jpg',
      });
      db.insert('estampado', {
        'id': 5,
        'img': 'assets/bali.jpg',
      });
      db.insert('estampado', {
        'id': 6,
        'img': 'assets/blackvelvet.jpg',
      });
      db.insert('estampado', {
        'id': 7,
        'img': 'assets/blanco.jpg',
      });
      db.insert('estampado', {
        'id': 8,
        'img': 'assets/blancobrillo.jpg',
      });
      db.insert('estampado', {
        'id': 9,
        'img': 'assets/blancomate.jpg',
      });
      db.insert('estampado', {
        'id': 10,
        'img': 'assets/bluefog.jpg',
      });
      db.insert('estampado', {
        'id': 11,
        'img': 'assets/bosquegreen.jpg',
      });
      db.insert('estampado', {
        'id': 12,
        'img': 'assets/caledonia.jpg',
      });
      db.insert('estampado', {
        'id': 13,
        'img': 'assets/castano.jpg',
      });
      db.insert('estampado', {
        'id': 14,
        'img': 'assets/cemento.jpg',
      });
      db.insert('estampado', {
        'id': 15,
        'img': 'assets/cielo.jpg',
      });
      db.insert('estampado', {
        'id': 16,
        'img': 'assets/eternity.jpg',
      });
      db.insert('estampado', {
        'id': 17,
        'img': 'assets/fresno.jpg',
      });
      db.insert('estampado', {
        'id': 18,
        'img': 'assets/granate.jpg',
      });
      db.insert('estampado', {
        'id': 19,
        'img': 'assets/gris.jpg',
      });
      db.insert('estampado', {
        'id': 20,
        'img': 'assets/havana.jpg',
      });
      db.insert('estampado', {
        'id': 21,
        'img': 'assets/humo.jpg',
      });
      db.insert('estampado', {
        'id': 22,
        'img': 'assets/intense.jpg',
      });
      db.insert('estampado', {
        'id': 23,
        'img': 'assets/macchiato.jpg',
      });
      db.insert('estampado', {
        'id': 24,
        'img': 'assets/marmol.jpg',
      });
      db.insert('estampado', {
        'id': 25,
        'img': 'assets/marmolblanco.jpg',
      });
      db.insert('estampado', {
        'id': 26,
        'img': 'assets/nata.jpg',
      });
      db.insert('estampado', {
        'id': 27,
        'img': 'assets/natural.jpg',
      });
      db.insert('estampado', {
        'id': 28,
        'img': 'assets/negro.jpg',
      });
      db.insert('estampado', {
        'id': 29,
        'img': 'assets/negromate.jpg',
      });
      db.insert('estampado', {
        'id': 30,
        'img': 'assets/nightblue.jpg',
      });
      db.insert('estampado', {
        'id': 31,
        'img': 'assets/nogal.jpg',
      });
      db.insert('estampado', {
        'id': 32,
        'img': 'assets/nordick.jpg',
      });
      db.insert('estampado', {
        'id': 33,
        'img': 'assets/ostippo.jpg',
      });
      db.insert('estampado', {
        'id': 34,
        'img': 'assets/paja.jpg',
      });
      db.insert('estampado', {
        'id': 35,
        'img': 'assets/piedragris.jpg',
      });
      db.insert('estampado', {
        'id': 36,
        'img': 'assets/pinobahia.jpg',
      });
      db.insert('estampado', {
        'id': 37,
        'img': 'assets/pure.jpg',
      });
      db.insert('estampado', {
        'id': 38,
        'img': 'assets/roble.jpg',
      });
      db.insert('estampado', {
        'id': 39,
        'img': 'assets/robleafrica.jpg',
      });
      db.insert('estampado', {
        'id': 40,
        'img': 'assets/rojo.jpg',
      });
      db.insert('estampado', {
        'id': 41,
        'img': 'assets/royalgreen.jpg',
      });
      db.insert('estampado', {
        'id': 42,
        'img': 'assets/salvia.jpg',
      });
      db.insert('estampado', {
        'id': 43,
        'img': 'assets/sol.jpg',
      });
      db.insert('estampado', {
        'id': 44,
        'img': 'assets/taupe.jpg',
      });
      db.insert('estampado', {
        'id': 45,
        'img': 'assets/verdeacido.jpg',
      });
      db.insert('estampado', {
        'id': 46,
        'img': 'assets/whitecotton.jpg',
      });
      db.insert('estampado', {
        'id': 47,
        'img': 'assets/terracota.jpg',
      });
      db.insert('estampado', {
        'id': 48,
        'img': 'assets/real.jpg',
      });
      db.insert('estampado', {
        'id': 49,
        'img': 'assets/negro.jpg',
      });
      db.insert('estampado', {
        'id': 50,
        'img': 'assets/almendra.jpg',
      });

      //Crear tabla productos con sus datos iniciales
      db.execute('CREATE TABLE tipo ('
          'id INTEGER PRIMARY KEY, '
          'idGama INTEGER, '
          'nombre TEXT, '
          'img TEXT, '
          'url INTEGER, '
          'isPortada BOOLEAN, '
          'FOREIGN KEY (idGama) REFERENCES gama (id) ON DELETE NO ACTION ON UPDATE NO ACTION '
          ');');

      //OPTIMUS
      db.insert('tipo', {
        'id': 1,
        'idGama': 1,
        'nombre': 'OPTIMUS 800 ROBLE CALEDONIA',
        'img': 'assets/so_optimus_600800_nordick_1_m.jpg',
        'url': 9,
      });

      db.insert('tipo', {
        'id': 2,
        'idGama': 1,
        'nombre': 'OPTIMUS 800 BLANCO MATE',
        'img': 'assets/so_optimus_800_blanco_1_m.jpg',
        'url': 9,
      });

      db.insert('tipo', {
        'id': 3,
        'idGama': 1,
        'nombre': 'OPTIMUS 1200 BLANCO MATE',
        'img': 'assets/so_optimus_aplique_blanco_1_m.jpg',
        'url': 9,
      });

      db.insert('tipo', {
        'id': 4,
        'idGama': 1,
        'nombre': 'OPTIMUS 800 BLANCO MATE',
        'img': 'assets/so_attila_600800_blanco_1_m.jpg',
        'url': 9,
      });

      db.insert('tipo', {
        'id': 5,
        'idGama': 1,
        'nombre': 'OPTIMUS 600 ROBLE CALEDONIA',
        'img': 'assets/so_optimus_intver_nordick_1_m.jpg',
        'url': 9,
      });

      db.insert('tipo', {
        'id': 6,
        'idGama': 1,
        'nombre': 'OPTIMUS 800 NEGRO MATE',
        'img': 'assets/so_optimus_posred_negro_1_m.jpg',
        'url': 9,
      });

      //ATTILA

      db.insert('tipo', {
        'id': 7,
        'idGama': 2,
        'nombre': 'ATTILA 3 CAJONES ROBLE OSTIPPO',
        'img': 'assets/so_attila_3cajones_ostippo_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 8,
        'idGama': 2,
        'nombre': 'ATTILA 800 BLANCO MATE',
        'img': 'assets/so_attila_600800_blanco_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 9,
        'idGama': 2,
        'nombre': 'ATTILA 800 ROBLE OSTIPPO',
        'img': 'assets/so_attila_800_ostippo_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 10,
        'idGama': 2,
        'nombre': 'ATTILA 800 ROBLE ETERNITY',
        'img': 'assets/so_attila_aplique_eternity_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 11,
        'idGama': 2,
        'nombre': 'ATTILA 1400 ROBLE ETERNITY',
        'img': 'assets/so_attila_intapli_eternity_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 12,
        'idGama': 2,
        'nombre': 'ATTILA 800 ROBLE ETERNITY',
        'img': 'assets/so_attila_intred_eternity_1_m.jpg',
        'url': 11,
      });
      db.insert('tipo', {
        'id': 13,
        'idGama': 2,
        'nombre': 'ATTILA 600 BLANCO MATE',
        'img': 'assets/so_attila_intretro_blanco_1_m.jpg',
        'url': 11,
      });

      //NOJA

      db.insert('tipo', {
        'id': 14,
        'idGama': 3,
        'nombre': 'NOJA 1200 BLANCO BRILLO',
        'img': 'assets/so_noja_1200_blanco_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 15,
        'idGama': 3,
        'nombre': 'NOJA 1400 GRIS MATE',
        'img': 'assets/so_noja_1400_gris_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 16,
        'idGama': 3,
        'nombre': 'NOJA 855 ROBLE ETERNITY',
        'img': 'assets/so_noja_855_eternity_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 17,
        'idGama': 3,
        'nombre': 'NOJA 600 ROBLE CALEDONIA',
        'img': 'assets/so_noja_cajones600_caledonia_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 18,
        'idGama': 3,
        'nombre': 'NOJA 800 BLANCO BRILLO',
        'img': 'assets/so_noja_cajones800_blanco_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 19,
        'idGama': 3,
        'nombre': 'NOJA 1 HUECO 1200 BLANCO BRILLO',
        'img': 'assets/so_noja_hueco1200_blanco_1_m.jpg',
        'url': 13,
      });

      db.insert('tipo', {
        'id': 20,
        'idGama': 3,
        'nombre': 'NOJA 1 HUECO 600 ROBLE ETERNITY',
        'img': 'assets/so_noja_hueco600_eternity_1_m.jpg',
        'url': 13,
      });

      //ARENYS

      db.insert('tipo', {
        'id': 21,
        'idGama': 4,
        'nombre': 'ARENYS 1200 GRIS MATE',
        'img': 'assets/so_arenys_1200_gris_1_m.jpg',
        'url': 15,
      });

      db.insert('tipo', {
        'id': 22,
        'idGama': 4,
        'nombre': 'ARENYS 600 ROBLE ETERNITY',
        'img': 'assets/so_arenys_600_eternity_1_m.jpg',
        'url': 15,
      });

      db.insert('tipo', {
        'id': 23,
        'idGama': 4,
        'nombre': 'ARENYS 855 BLANCO BRILLO',
        'img': 'assets/so_arenys_855_blanco_1_m.jpg',
        'url': 15,
      });

      //ALMAGRO

      db.insert('tipo', {
        'id': 24,
        'idGama': 5,
        'nombre': 'ALMAGRO 500 BLANCO BRILLO',
        'img': 'assets/so_almagro_500_blanco_1_m.jpg',
        'url': 17,
      });

      db.insert('tipo', {
        'id': 25,
        'idGama': 5,
        'nombre': 'ALMAGRO 700 ROBLE CALEDONIA',
        'img': 'assets/so_almagro_700_caledonia_1_m.jpg',
        'url': 17,
      });

      //MICRO

      //Este va directo al producto
      db.insert('tipo', {
        'id': 201,
        'idGama': 6,
        'nombre': 'MICRO',
        'img': 'assets/so_gama_micro_portada_5.jpg',
        'url': 19,
      });

      //PMR

      db.insert('tipo', {
        'id': 26,
        'idGama': 7,
        'nombre': 'PMR EASY BATH 800',
        'img': 'assets/so_pmr_ciclo2_nocolor_1_m.jpg',
        'url': 21,
      });

      db.insert('tipo', {
        'id': 27,
        'idGama': 7,
        'nombre': 'PMR EASY BATH 1300',
        'img': 'assets/so_pmr_ciclo2_nocolor_1_m.jpg',
        'url': 21,
      });

      //ESPEJOS

      db.insert('tipo', {
        'id': 28,
        'idGama': 8,
        'nombre': 'ALCOR',
        'img': 'assets/so_espejos_alcor_nocolor_1_m.jpg',
        'url': '#',
      });

      db.insert('tipo', {
        'id': 29,
        'idGama': 8,
        'nombre': 'LOIRA 600',
        'img': 'assets/so_espejos_loira600_nocolor_1_m.jpg',
        'url': 28,
      });

      db.insert('tipo', {
        'id': 30,
        'idGama': 8,
        'nombre': 'LOIRA 800',
        'img': 'assets/so_espejos_loira800_nocolor_1_m.jpg',
        'url': 28,
      });

      db.insert('tipo', {
        'id': 31,
        'idGama': 8,
        'nombre': 'SCHWAN',
        'img': 'assets/so_espejos_schwan600_nocolor_1_m.jpg',
        'url': 28,
      });

      //PANELES

      //Este va directo al producto
      db.insert('tipo', {
        'id': 202,
        'idGama': 9,
        'nombre': 'PANELES',
        'img': 'assets/so_paneles_panel_gris_1_m.jpg',
        'url': 36,
      });

      //INFINITY

      db.insert('tipo', {
        'id': 32,
        'idGama': 10,
        'nombre': 'MODULOS 1 PUERTA BLANCO BRILLO',
        'img': 'assets/so_infinity_mod1puerta_blanco_1_m.jpg',
        'url': 37,
      });

      db.insert('tipo', {
        'id': 33,
        'idGama': 10,
        'nombre': 'MODULOS 2 PUERTAS ROBLE CALEDONIA',
        'img': 'assets/so_infinity_mod2puertas_caledonia_1_m.jpg',
        'url': 37,
      });

      db.insert('tipo', {
        'id': 34,
        'idGama': 10,
        'nombre': 'PILAR 2 PUERTAS BLANCO BRILLO',
        'img': 'assets/so_infinity_pilar2puertas_blanco_1_m.jpg',
        'url': 37,
      });

      db.insert('tipo', {
        'id': 35,
        'idGama': 10,
        'nombre': 'PILAR 2 PUERTAS ROBE ETERNITY',
        'img': 'assets/so_infinity_pilar4puertas_eternity_1_m.jpg',
        'url': 37,
      });

      //CATALOGO GENERAL
      //SERIE ORIGINAL
      //MOMENT

      db.insert('tipo', {
        'id': 36,
        'idGama': 12,
        'nombre': 'MOMENT 1000 PURE',
        'img': 'assets/cg_or_moment_1000_fresno_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 37,
        'idGama': 12,
        'nombre': 'MOMENT 1200 PURE',
        'img': 'assets/cg_or_moment_1200pure_fresno_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 38,
        'idGama': 12,
        'nombre': 'MOMENT 1200 REAL',
        'img': 'assets/cg_or_moment_1200real_fresno_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 39,
        'idGama': 12,
        'nombre': 'MOMENT 1370 INTENSE',
        'img': 'assets/cg_or_moment_1370intense_nogal_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 40,
        'idGama': 12,
        'nombre': 'MOMENT 1490 PURE',
        'img': 'assets/cg_or_moment_1490pure_fresno_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 41,
        'idGama': 12,
        'nombre': 'MOMENT 1600 REAL',
        'img': 'assets/cg_or_moment_1600real_roble_1_m.jpg',
        'url': 8,
      });

      db.insert('tipo', {
        'id': 42,
        'idGama': 12,
        'nombre': 'MOMENT 2000 INTENSE',
        'img': 'assets/cg_or_moment_2000intense_nogal_1_m.jpg',
        'url': 8,
      });
/*
      db.insert('tipo', {
        'id': 43,
        'idGama': 12,
   13     'nombre': 'MOMENT 2000 INTENSE',
        'img': 'assets/cg_or_moment_2000intense_nogal_1_m.jpg',
        'url': '#',
      });
*/
      db.insert('tipo', {
        'id': 44,
        'idGama': 12,
        'nombre': 'MOMENT 600 PURE',
        'img': 'assets/cg_or_moment_600pure_fresno_1_m.jpg',
        'url': 8,
      });

      //RENOIR

      db.insert('tipo', {
        'id': 45,
        'idGama': 13,
        'nombre': 'RENOIR 600 WHITE COTTON',
        'img': 'assets/cg_or_renoir_600wc_blancomate_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 46,
        'idGama': 13,
        'nombre': 'RENOIR 600 BLACK VELVET',
        'img': 'assets/cg_or_renoir_600bv_nocolor_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 47,
        'idGama': 13,
        'nombre': 'RENOIR 800 WHITE COTTON',
        'img': 'assets/cg_or_renoir_800wc_blancomate_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 48,
        'idGama': 13,
        'nombre': 'RENOIR 800 MACCHIATO',
        'img': 'assets/cg_or_renoir_800m_macchiato_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 49,
        'idGama': 13,
        'nombre': 'RENOIR 1000 ANTRACITA',
        'img': 'assets/cg_or_renoir_1000antracita_antracita_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 50,
        'idGama': 13,
        'nombre': 'RENOIR 1000 GREEN FOREST',
        'img': 'assets/cg_or_renoir_1000gf_bosquegreen_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 51,
        'idGama': 13,
        'nombre': 'RENOIR 1370 NIGHT BLUE',
        'img': 'assets/cg_or_renoir_1370nb_nightblue_1_m.jpg',
        'url': 10,
      });

      db.insert('tipo', {
        'id': 52,
        'idGama': 13,
        'nombre': 'RENOIR 1370 BLUE FOG',
        'img': 'assets/cg_or_renoir_1600bf_bluefog_1_m.jpg',
        'url': 10,
      });

      //MAM
      db.insert('tipo', {
        'id': 53,
        'idGama': 14,
        'nombre': 'MAM 1200/D BLACK VELVET',
        'img': 'assets/cg_or_mam_1200bv_negro_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 54,
        'idGama': 14,
        'nombre': 'MAM 1200/I NIGHT BLUE',
        'img': 'assets/cg_or_mam_1200nb_nightblue_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 55,
        'idGama': 14,
        'nombre': 'MAM 1200/I WHITE COTTON',
        'img': 'assets/cg_or_mam_1200wc_whitecotton_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 56,
        'idGama': 14,
        'nombre': 'MAM 1500/I ANTRACITA',
        'img': 'assets/cg_or_mam_1500antracita_antracita_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 57,
        'idGama': 14,
        'nombre': 'MAM 1500/I MACCHIATO',
        'img': 'assets/cg_or_mam_1500l_macchiato_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 58,
        'idGama': 14,
        'nombre': 'MAM 900/D BLUE FOG',
        'img': 'assets/cg_or_mam_900bf_bluefog_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 59,
        'idGama': 14,
        'nombre': 'MAM 900/I BLACK VELVET',
        'img': 'assets/cg_or_mam_900bv_negro_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 60,
        'idGama': 14,
        'nombre': 'MAM 900/I GREEN FOREST',
        'img': 'assets/cg_or_mam_900i_bosquegreen_1_m.jpg',
        'url': 14,
      });

      db.insert('tipo', {
        'id': 61,
        'idGama': 14,
        'nombre': 'MAM 900/D WHITE COTTON',
        'img': 'assets/cg_or_mam_900wc_whitecotton_1_m.jpg',
        'url': 14,
      });

      //UNIIQ

      db.insert('tipo', {
        'id': 62,
        'idGama': 15,
        'nombre': 'UNIIQ 600 BLANCO MATE',
        'img': 'assets/cg_or_uniiq_600_blancomate_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 63,
        'idGama': 15,
        'nombre': 'UNIIQ 800 TERRACOTA',
        'img': 'assets/cg_or_uniiq_800tr_terracota_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 64,
        'idGama': 15,
        'nombre': 'UNIIQ 800 BOSQUE / SALVIA',
        'img': 'assets/cg_or_uniiq_800bs_bosquesalvia_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 65,
        'idGama': 15,
        'nombre': 'UNIIQ 800 HUMO',
        'img': 'assets/cg_or_uniiq_800_bluefog_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 66,
        'idGama': 15,
        'nombre': 'UNIIQ 900/I BLUE FOG',
        'img': 'assets/cg_or_uniiq_900i_bluefog_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 67,
        'idGama': 15,
        'nombre': 'UNIIQ 900/D ROYAL GREEN',
        'img': 'assets/cg_or_uniiq_900g_royalgreen_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 68,
        'idGama': 15,
        'nombre': 'UNIIQ 900/D NEGRO',
        'img': 'assets/cg_or_uniiq_900n_negro_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 69,
        'idGama': 15,
        'nombre': 'UNIIQ 1200/I NATA',
        'img': 'assets/cg_or_uniiq_1200n_nata_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 70,
        'idGama': 15,
        'nombre': 'UNIIQ 1200/D ANTRACITA',
        'img': 'assets/cg_or_uniiq_1200a_antracita_1_m.jpg',
        'url': 16,
      });

      db.insert('tipo', {
        'id': 71,
        'idGama': 15,
        'nombre': 'UNIIQ 1200/I NIGHT BLUE',
        'img': 'assets/cg_or_uniiq_1200ni_nightblue_1_m.jpg',
        'url': 16,
      });

      //COMPAKT

      db.insert('tipo', {
        'id': 72,
        'idGama': 16,
        'nombre': 'COMPAKT 1300 BALI',
        'img': 'assets/cg_or_compakt_1300_bali_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 73,
        'idGama': 16,
        'nombre': 'COMPAKT 1400 HAVANA',
        'img': 'assets/cg_or_compakt_1400_havana_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 74,
        'idGama': 16,
        'nombre': 'COMPAKT 1400 MÁRMOL BLANCO',
        'img': 'assets/cg_or_compakt_1400ma_marmol_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 75,
        'idGama': 16,
        'nombre': 'COMPAKT 1600 BALI',
        'img': 'assets/cg_or_compakt_1600_bali_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 76,
        'idGama': 16,
        'nombre': 'COMPAKT 1600 CEMENTO',
        'img': 'assets/cg_or_compakt_1600ce_cemento_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 77,
        'idGama': 16,
        'nombre': 'COMPAKT 1600 MÁRMOL BLANCO',
        'img': 'assets/cg_or_compakt_1600mar_marmolblanco_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 78,
        'idGama': 16,
        'nombre': 'COMPAKT 1600 ROBLE ÁFRICA',
        'img': 'assets/cg_or_compakt_1600ro_robleafrica_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 79,
        'idGama': 16,
        'nombre': 'COMPAKT 1750 PIEDRA GRIS',
        'img': 'assets/cg_or_compakt_1750_gris_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 80,
        'idGama': 16,
        'nombre': 'COMPAKT 1800 HAVANA',
        'img': 'assets/cg_or_compakt_1800_havana_1_m.jpg',
        'url': 12,
      });
      db.insert('tipo', {
        'id': 611,
        'idGama': 16,
        'nombre': 'COMPAKT 1800 HAVANA',
        'img': 'assets/cg_or_compakt_1800h_havana_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 81,
        'idGama': 16,
        'nombre': 'COMPAKT DOBLE 2000 PIEDRA GRIS',
        'img': 'assets/cg_or_compakt_2000_gris_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 82,
        'idGama': 16,
        'nombre': 'COMPAKT 2180 ROBLE ÁFRICA',
        'img': 'assets/cg_or_compakt_2180_robleafrica_1_m.jpg',
        'url': 12,
      });

      db.insert('tipo', {
        'id': 83,
        'idGama': 16,
        'nombre': 'COMPAKT 600 PIEDRA GRIS',
        'img': 'assets/cg_or_compakt_600_gris_1_m.jpg',
        'url': 12,
      });

      //SERIE MODULAR
      //A MEDIDA

      db.insert('tipo', {
        'id': 84,
        'idGama': 17,
        'nombre': 'CAMBIO DE BAÑERA A DUCHA',
        'img': 'assets/cg_mo_medida_cambiobanera_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 85,
        'idGama': 17,
        'nombre': 'GANA ALMACENAJE EN TU BAÑO',
        'img': 'assets/cg_mo_medida_ganaalmacenajebano_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 86,
        'idGama': 17,
        'nombre': 'UN NUEVO ESTILO PARA TU BAÑO',
        'img': 'assets/cg_mo_medida_nuevoestilo_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 87,
        'idGama': 17,
        'nombre': 'PREPARA TU BAÑO PARA LA EDAD DE ORO',
        'img': 'assets/cg_mo_medida_preparatubano_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 88,
        'idGama': 17,
        'nombre': 'SACA PARTIDO A TU DISTRIBUCIÓN',
        'img': 'assets/cg_mo_medida_sacapartido_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 89,
        'idGama': 17,
        'nombre': 'SOLUCIONA TUS PROBLEMAS ARQUITECTÓNICOS',
        'img': 'assets/cg_mo_medida_solucionaproblemas_nocolor_1_m.jpg',
        'url': 40,
      });

      db.insert('tipo', {
        'id': 90,
        'idGama': 17,
        'nombre': 'TRANSFORMA TU CUARTO DE LAVADORA',
        'img': 'assets/cg_mo_medida_transformacuarto_nocolor_1_m.jpg',
        'url': 40,
      });

      //MONTERREY

      db.insert('tipo', {
        'id': 91,
        'idGama': 18,
        'nombre': 'MONTERREY 1000 BLACK VELVET',
        'img': 'assets/cg_mo_monterrey_1000bv_alsacia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 92,
        'idGama': 18,
        'nombre': 'MONTERREY 1000 PINO BAHÍA',
        'img': 'assets/cg_mo_monterrey_1000p_pinobahia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 93,
        'idGama': 18,
        'nombre': 'MONTERREY 1000 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_monterrey_1000ro_robleafrica_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 94,
        'idGama': 18,
        'nombre': 'MONTERREY 1200 ALSACIA',
        'img': 'assets/cg_mo_monterrey_1200al_alsacia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 95,
        'idGama': 18,
        'nombre': 'MONTERREY 1200 ALSACIA',
        'img': 'assets/cg_mo_monterrey_1200b_alsacia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 96,
        'idGama': 18,
        'nombre': 'MONTERREY 1200/D BLUEFOG',
        'img': 'assets/cg_mo_monterrey_1200bl_bluefog_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 97,
        'idGama': 18,
        'nombre': 'MONTERREY 1200 NATURAL',
        'img': 'assets/cg_mo_monterrey_1200na_natural_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 98,
        'idGama': 18,
        'nombre': 'MONTERREY 1210 BLACK VELVET',
        'img': 'assets/cg_mo_monterrey_1210_blackvelvet_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 99,
        'idGama': 18,
        'nombre': 'MONTERREY 1390/I ALSACIA',
        'img': 'assets/cg_mo_monterrey_1390i_alsacia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 100,
        'idGama': 18,
        'nombre': 'MONTERREY 1400/I MACCHIATO',
        'img': 'assets/cg_mo_monterrey_1400ma_macchiato_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 101,
        'idGama': 18,
        'nombre': 'MONTERREY 1400 NIGHT BLUE',
        'img': 'assets/cg_mo_monterrey_1400nb_nightblue_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 102,
        'idGama': 18,
        'nombre': 'MONTERREY 1400/I WHITE COTTON',
        'img': 'assets/cg_mo_monterrey_1400wc_whitecotton_1_m.jpg',
        'url': 20,
      });
      db.insert('tipo', {
        'id': 612,
        'idGama': 18,
        'nombre': 'MONTERREY 1500 PINO BAHÍA',
        'img': 'assets/cg_mo_monterrey_1500pb_pinobahia_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 103,
        'idGama': 18,
        'nombre': 'MONTERREY 1500 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_monterrey_1500ro_robleafrica_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 104,
        'idGama': 18,
        'nombre': 'MONTERREY 1600/I ROBLE ÁFRICA',
        'img': 'assets/cg_mo_monterrey_1600i_robleafrica_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 105,
        'idGama': 18,
        'nombre': 'MONTERREY 1710 GREEN FOREST',
        'img': 'assets/cg_mo_monterrey_1710_bosquegreen_1_m.jpg',
        'url': 20,
      });

      db.insert('tipo', {
        'id': 106,
        'idGama': 18,
        'nombre': 'MONTERREY 800 BLANCO BRILLO',
        'img': 'assets/cg_mo_monterrey_800_blanco_1_m.jpg',
        'url': 20,
      });

      //SPIRIT

      db.insert('tipo', {
        'id': 107,
        'idGama': 19,
        'nombre': 'SPIRIT 1000 ALSACIA',
        'img': 'assets/cg_mo_spirit_1000al_alsacia_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 108,
        'idGama': 19,
        'nombre': 'SPIRIT 1000/D WHITE COTTON',
        'img': 'assets/cg_mo_spirit_1000d_whitecotton_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 109,
        'idGama': 19,
        'nombre': 'SPIRIT 1000 NATURAL',
        'img': 'assets/cg_mo_spirit_1000na_natural_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 110,
        'idGama': 19,
        'nombre': 'SPIRIT 1090/I ALSACIA',
        'img': 'assets/cg_mo_spirit_1090i_alsacia_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 111,
        'idGama': 19,
        'nombre': 'SPIRIT 1200 PINO BAHÍA',
        'img': 'assets/cg_mo_spirit_1200_pinobahia_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 112,
        'idGama': 19,
        'nombre': 'SPIRIT 1200/I NATURAL',
        'img': 'assets/cg_mo_spirit_1200i_natural_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 113,
        'idGama': 19,
        'nombre': 'SPIRIT 1200 NATURAL',
        'img': 'assets/cg_mo_spirit_1200na_natural_1_m.jpg',
        'url': 22,
      });
      db.insert('tipo', {
        'id': 114,
        'idGama': 19,
        'nombre': 'SPIRIT 1400 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_spirit_1400_robleafrica_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 115,
        'idGama': 19,
        'nombre': 'SPIRIT 1400/I BLACK VELVET',
        'img': 'assets/cg_mo_spirit_1400i_blackvelvet_1_m.jpg',
        'url': 22,
      });
      db.insert('tipo', {
        'id': 116,
        'idGama': 19,
        'nombre': 'SPIRIT 1500 WHITE COTTON',
        'img': 'assets/cg_mo_spirit_1500_whitecotton_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 117,
        'idGama': 19,
        'nombre': 'SPIRIT 1600 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_spirit_1600_robleafrica_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 118,
        'idGama': 19,
        'nombre': 'SPIRIT 1600 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_spirit_1600ro_robleafrica_1_m.jpg',
        'url': 22,
      });
      db.insert('tipo', {
        'id': 119,
        'idGama': 19,
        'nombre': 'SPIRIT 1800 NATURAL',
        'img': 'assets/cg_mo_spirit_1800_natural_1_m.jpg',
        'url': 22,
      });
      db.insert('tipo', {
        'id': 120,
        'idGama': 19,
        'nombre': 'SPIRIT 700 BLANCO BRILLO',
        'img': 'assets/cg_mo_spirit_700bb_blancobrillo_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 121,
        'idGama': 19,
        'nombre': 'SPIRIT 700 PINO BAHÍA',
        'img': 'assets/cg_mo_spirit_700pb_pinobahia_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 122,
        'idGama': 19,
        'nombre': 'SPIRIT 700 BLACK VELVET',
        'img': 'assets/cg_mo_spirit_800bv_blackvelvet_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 123,
        'idGama': 19,
        'nombre': 'SPIRIT 800 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_spirit_800ro_robleafrica_1_m.jpg',
        'url': 22,
      });

      db.insert('tipo', {
        'id': 124,
        'idGama': 19,
        'nombre': 'SPIRIT 800 WHITE COTTON',
        'img': 'assets/cg_mo_spirit_800wc_whitecotton_1_m.jpg',
        'url': 22,
      });

      //FUSSION LINE

      db.insert('tipo', {
        'id': 125,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1000/D ALSACIA',
        'img': 'assets/cg_mo_fussion_1000d_alsacia_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 126,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1200 BLACK VELVET',
        'img': 'assets/cg_mo_fussion_1200bv_blackvelvet_1_m.jpg',
        'url': 23,
      });

      db.insert('tipo', {
        'id': 127,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1200/C NATURAL',
        'img': 'assets/cg_mo_fussion_1200c_natural_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 128,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1200/D WHITE COTTON',
        'img': 'assets/cg_mo_fussion_1200d_whitecotton_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 129,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1200 NATURAL',
        'img': 'assets/cg_mo_fussion_1200na_natural_1_m.jpg',
        'url': 23,
      });

      db.insert('tipo', {
        'id': 130,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1400 ALSACIA',
        'img': 'assets/cg_mo_fussion_1400_alsacia_1_m.jpg',
        'url': 23,
      });

      db.insert('tipo', {
        'id': 131,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1400/C PINO BAHÍA',
        'img': 'assets/cg_mo_fussion_1400c_pinobahia_1_m.jpg',
        'url': 23,
      });

      db.insert('tipo', {
        'id': 132,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1500 ALSACIA',
        'img': 'assets/cg_mo_fussion_1500_alsacia_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 133,
        'idGama': 20,
        'nombre': 'FUSSION LINE 1700 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_fussion_1700_robleafrica_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 134,
        'idGama': 20,
        'nombre': 'FUSSION LINE 600 WHITE COTTON',
        'img': 'assets/cg_mo_fussion_600_whitecotton_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 135,
        'idGama': 20,
        'nombre': 'FUSSION LINE 700 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_fussion_700_robleafrica_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 136,
        'idGama': 20,
        'nombre': 'FUSSION LINE 700 BLACK VELVET',
        'img': 'assets/cg_mo_fussion_700bv_blackvelvet_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 137,
        'idGama': 20,
        'nombre': 'FUSSION LINE 800 ALSACIA',
        'img': 'assets/cg_mo_fussion_800_alsacia_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 138,
        'idGama': 20,
        'nombre': 'FUSSION LINE 900 BLACK VELVET',
        'img': 'assets/cg_mo_fussion_900_blackvelvet_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 139,
        'idGama': 20,
        'nombre': 'FUSSION LINE 900/D NATURAL',
        'img': 'assets/cg_mo_fussion_900d_natural_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 140,
        'idGama': 20,
        'nombre': 'FUSSION LINE 900/I NATURAL',
        'img': 'assets/cg_mo_fussion_900i_natural_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 141,
        'idGama': 20,
        'nombre': 'FUSSION LINE DOBLE 1400 NATURAL',
        'img': 'assets/cg_mo_fussion_doble1400_natural_1_m.jpg',
        'url': 23,
      });
      db.insert('tipo', {
        'id': 142,
        'idGama': 20,
        'nombre': 'FUSSION LINE 900/I ROBLE ÁFRICA',
        'img': 'assets/cg_mo_fussion_900iro_robleafrica_1_m.jpg',
        'url': 23,
      });

      //REDUCIDO

      db.insert('tipo', {
        'id': 143,
        'idGama': 21,
        'nombre': 'FUSSION 35 500 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_reducido_35500ro_robleafrica_1_m.jpg',
        'url': 24,
      });
      db.insert('tipo', {
        'id': 144,
        'idGama': 21,
        'nombre': 'FUSSION 35 500 WHITE COTTON',
        'img': 'assets/cg_mo_reducido_35500wc_blanco_1_m.jpg',
        'url': 24,
      });
      db.insert('tipo', {
        'id': 145,
        'idGama': 21,
        'nombre': 'FUSSION 35 700 BLACK VELVET',
        'img': 'assets/cg_mo_reducido_35700bv_blackvelvet_1_m.jpg',
        'url': 24,
      });
      db.insert('tipo', {
        'id': 146,
        'idGama': 21,
        'nombre': 'FUSSION 35 700 NATURAL',
        'img': 'assets/cg_mo_reducido_35700na_natural_1_m.jpg',
        'url': 24,
      });
      db.insert('tipo', {
        'id': 147,
        'idGama': 21,
        'nombre': 'FUSSION 35 700 PINO BAHÍA',
        'img': 'assets/cg_mo_reducido_35700pb_pinobahia_1_m.jpg',
        'url': 24,
      });
      db.insert('tipo', {
        'id': 148,
        'idGama': 21,
        'nombre': 'FUSSION 40 500 ALSACIA',
        'img': 'assets/cg_mo_reducido_40500al_alsacia_1_m.jpg',
        'url': 25,
      });
      db.insert('tipo', {
        'id': 149,
        'idGama': 21,
        'nombre': 'FUSSION 40 500 ROBLE ÁFRICA',
        'img': 'assets/cg_mo_reducido_40500ro_robleafrica_1_m.jpg',
        'url': 25,
      });
      db.insert('tipo', {
        'id': 150,
        'idGama': 21,
        'nombre': 'FUSSION 40 700 BLACK VELVET',
        'img': 'assets/cg_mo_reducido_40700bv_blackvelvet_1_m.jpg',
        'url': 25,
      });
      db.insert('tipo', {
        'id': 151,
        'idGama': 21,
        'nombre': 'FUSSION 40 700 NATURAL',
        'img': 'assets/cg_mo_reducido_40700na_natural_1_m.jpg',
        'url': 25,
      });
      db.insert('tipo', {
        'id': 152,
        'idGama': 21,
        'nombre': 'FUSSION 40 700 WHITE COTTON',
        'img': 'assets/cg_mo_reducido_40700wc_blanco_1_m.jpg',
        'url': 25,
      });
      db.insert('tipo', {
        'id': 153,
        'idGama': 21,
        'nombre': 'MARTHA ALSACIA',
        'img': 'assets/cg_mo_reducido_marthaal_alsacia_1_m.jpg',
        'url': 26,
      });
      db.insert('tipo', {
        'id': 154,
        'idGama': 21,
        'nombre': 'MARTHA ROBLE ÁFRICA',
        'img': 'assets/cg_mo_reducido_martharo_robleafrica_1_m.jpg',
        'url': 26,
      });

      //AUXILIARES
      db.insert('tipo', {
        'id': 155,
        'idGama': 22,
        'nombre': 'COQUETA 1 HUECO',
        'img': 'assets/cg_mo_auxiliares_coqueta1hueco_robleafrica_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 156,
        'idGama': 22,
        'nombre': 'COQUETA 1 PUERTA',
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_alsacia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 157,
        'idGama': 22,
        'nombre': 'COQUETA 1 PUERTA A SUELO',
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_alsacia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 158,
        'idGama': 22,
        'nombre': 'COQUETA 1 PUERTA CURVA',
        'img': 'assets/cg_mo_auxiliares_coqueta1puertacurva_negro_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 159,
        'idGama': 22,
        'nombre': 'COQUETA 2 HUECOS',
        'img': 'assets/cg_mo_auxiliares_coqueta2puertas_pinobahia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 160,
        'idGama': 22,
        'nombre': 'COQUETA DOBLE FONDO 2 HUECOS',
        'img': 'assets/cg_mo_auxiliares_coqueta2puertasdoblef_alsacia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 161,
        'idGama': 22,
        'nombre': 'COQUETA DOBLE FONDO 2 HUECOS',
        'img': 'assets/cg_mo_auxiliares_coqueta2puertasdoblef_alsacia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 162,
        'idGama': 22,
        'nombre': 'COQUETA TOALLERO',
        'img': 'assets/cg_mo_auxiliares_coquetatoallero_whitecotton_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 163,
        'idGama': 22,
        'nombre': 'MODULO 1 PUERTA',
        'img': 'assets/cg_mo_auxiliares_modulo1puerta_negro_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 164,
        'idGama': 22,
        'nombre': 'MODULO 1 HUECO',
        'img': 'assets/cg_mo_auxiliares_modulo_alsacia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 165,
        'idGama': 22,
        'nombre': 'PILAR 2 PUERTAS',
        'img': 'assets/cg_mo_auxiliares_pilar2puertas_blancobrillo_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 166,
        'idGama': 22,
        'nombre': 'PILAR 1 PUERTA',
        'img': 'assets/cg_mo_auxiliares_pilar_pinobahia_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 167,
        'idGama': 22,
        'nombre': 'SEMIPILAR',
        'img': 'assets/cg_mo_auxiliares_semipilar_blancobrillo_1_m.jpg',
        'url': 41,
      });
      db.insert('tipo', {
        'id': 168,
        'idGama': 22,
        'nombre': 'TOCADOR',
        'img': 'assets/cg_mo_auxiliares_tocador_alsacia_1_m.jpg',
        'url': 41,
      });

      //LAVABO
      db.insert('tipo', {
        'id': 169,
        'idGama': 23,
        'nombre': 'MAM',
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_1_m.jpg',
        'url': 14,
      });
      db.insert('tipo', {
        'id': 170,
        'idGama': 23,
        'nombre': 'ALLIANCE',
        'img': 'assets/cg_lavabos_lavabo_alliance_nocolor_1_m.jpg',
        'url': 46,
      });
      db.insert('tipo', {
        'id': 171,
        'idGama': 23,
        'nombre': 'CONSTANZA',
        'img': 'assets/cg_lavabos_lavabo_constanza_nocolor_1_m.jpg',
        'url': 42,
      });
      db.insert('tipo', {
        'id': 172,
        'idGama': 23,
        'nombre': 'DE POSAR',
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_1_m.jpg',
        'url': 47,
      });
      db.insert('tipo', {
        'id': 173,
        'idGama': 23,
        'nombre': 'MAEL',
        'img': 'assets/cg_lavabos_lavabo_mael_nocolor_1_m.jpg',
        'url': 27,
      });
      db.insert('tipo', {
        'id': 174,
        'idGama': 23,
        'nombre': 'MARTHA',
        'img': 'assets/cg_lavabos_lavabo_martha_nocolor_1_m.jpg',
        'url': 27,
      });
      db.insert('tipo', {
        'id': 175,
        'idGama': 23,
        'nombre': 'S35',
        'img': 'assets/cg_lavabos_lavabo_s35_nocolor_1_m.jpg',
        'url': 27,
      });
      db.insert('tipo', {
        'id': 176,
        'idGama': 23,
        'nombre': 'S40',
        'img': 'assets/cg_lavabos_lavabo_s40_nocolor_1_m.jpg',
        'url': 27,
      });
      db.insert('tipo', {
        'id': 177,
        'idGama': 23,
        'nombre': 'TOSCANA',
        'img': 'assets/cg_lavabos_lavabo_toscana_nocolor_1_m.jpg',
        'url': 44,
      });
      db.insert('tipo', {
        'id': 178,
        'idGama': 23,
        'nombre': 'UNIIQ',
        'img': 'assets/cg_lavabos_lavabo_uniiq_nocolor_1_m.jpg',
        'url': 57,
      });
      db.insert('tipo', {
        'id': 179,
        'idGama': 23,
        'nombre': 'VENETO',
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_1_m.jpg',
        'url': 43,
      });
      db.insert('tipo', {
        'id': 180,
        'idGama': 23,
        'nombre': 'VILNA',
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_1_m.jpg',
        'url': 45,
      });

      //ESPEJOS Y APLIQUES
      db.insert('tipo', {
        'id': 181,
        'idGama': 24,
        'nombre': 'APLIQUES',
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_1_m.jpg',
        'url': 48,
      });

      db.insert('tipo', {
        'id': 182,
        'idGama': 24,
        'nombre': 'ESPEJOS',
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_1_m.jpg',
        'url': 48,
      });

      //ACCESORIOS
      db.insert('tipo', {
        'id': 183,
        'idGama': 25,
        'nombre': 'LLOYD',
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_1_m.jpg',
        'url': 49,
      });
      db.insert('tipo', {
        'id': 184,
        'idGama': 25,
        'nombre': 'NILO',
        'img': 'assets/cg_lavabos_espejoyaccesorios_nilo_nocolor_1_m.jpg',
        'url': 49,
      });
      db.insert('tipo', {
        'id': 185,
        'idGama': 25,
        'nombre': 'OBI',
        'img': 'assets/cg_lavabos_espejoyaccesorios_obi_nocolor_1_m.jpg',
        'url': 49
      });
      db.insert('tipo', {
        'id': 186,
        'idGama': 25,
        'nombre': 'SHIRO',
        'img': 'assets/cg_lavabos_espejoyaccesorios_shiro_nocolor_1_m.jpg',
        'url': 49
      });
      db.insert('tipo', {
        'id': 187,
        'idGama': 25,
        'nombre': 'SOLID SURFACE',
        'img':
            'assets/cg_lavabos_espejoyaccesorios_solidsurface_nocolor_1_m.jpg',
        'url': 49,
      });

      //MAMPARAS

      db.insert('tipo', {
        'id': 188,
        'idGama': 26,
        'nombre': 'PLATOS DE DUCHA',
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_1_m.jpg',
        'url': 30,
      });

      //PUERTAS CORREDERAS
      db.insert('tipo', {
        'id': 192,
        'idGama': 28,
        'nombre': 'CLEAR',
        'img': 'assets/cg_mamparas_puertascorrederas_clear_nocolor_1_1_m.jpg',
        'url': 31,
      });
      db.insert('tipo', {
        'id': 193,
        'idGama': 28,
        'nombre': 'COPENHAGUE',
        'img':
            'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_1_2_m.jpg',
        'url': 31,
      });

      db.insert('tipo', {
        'id': 194,
        'idGama': 28,
        'nombre': 'HELSINKI',
        'img':
            'assets/cg_mamparas_puertascorrederas_helsinki_nocolor_1_3_m.jpg',
        'url': 31,
      });
      db.insert('tipo', {
        'id': 195,
        'idGama': 28,
        'nombre': 'REIKIAVIK',
        'img':
            'assets/cg_mamparas_puertascorrederas_reikiavik_nocolor_1_4_m.jpg',
        'url': 31,
      });

      db.insert('tipo', {
        'id': 196,
        'idGama': 28,
        'nombre': 'KAAIVI',
        'img': 'assets/cg_mamparas_puertascorrederas_kaaivi_nocolor_1_5_m.jpg',
        'url': 31,
      });

      //ABATIBLES
      db.insert('tipo', {
        'id': 197,
        'idGama': 29,
        'nombre': 'HABITAT',
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_1_m.jpg',
        'url': 50,
      });
      db.insert('tipo', {
        'id': 198,
        'idGama': 29,
        'nombre': 'MALMO',
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_1_m.jpg',
        'url': 50,
      });
      db.insert('tipo', {
        'id': 199,
        'idGama': 29,
        'nombre': 'ODENSE',
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_1_m.jpg',
        'url': 50,
      });
      db.insert('tipo', {
        'id': 200,
        'idGama': 29,
        'nombre': 'VITTE',
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_1_m.jpg',
        'url': 50,
      });

      //DE PASO Y FIJAS
      db.insert('tipo', {
        'id': 203,
        'idGama': 27,
        'nombre': 'DE PASOS Y FIJOS',
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_1_m.jpg',
        'url': 33,
      });

      //Crear tabla subTipo con sus datos iniciales
      db.execute('CREATE TABLE subTipo  ('
          'id INTEGER PRIMARY KEY, '
          'idTipo INTEGER, '
          'nombre TEXT, '
          'img TEXT, '
          'url INTEGER, '
          'FOREIGN KEY (idTipo) REFERENCES tipo (id) ON DELETE NO ACTION ON UPDATE NO ACTION '
          ');');

      //PUERTAS CORREDERAS

      //HELSINKI
      db.insert('subTipo', {
        'id': 1,
        'idTipo': 194,
        'nombre': 'FRONTAL 1 PUERTA ENTRE PAREDES',
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_1_m.jpg',
        'url': 31,
      });
      db.insert('subTipo', {
        'id': 2,
        'idTipo': 194,
        'nombre': 'FRONTAL 2 PUERTAS ENTRE PAREDES',
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_1_m.jpg',
        'url': 31,
      });
      db.insert('subTipo', {
        'id': 3,
        'idTipo': 194,
        'nombre': 'FRONTAL 1 PUERTA CON LATERAL',
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_1_m.jpg',
        'url': 31,
      });
      db.insert('subTipo', {
        'id': 4,
        'idTipo': 194,
        'nombre': 'FRONTAL 2 PUERTAS 2 FIJOS',
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_1_m.jpg',
        'url': 31,
      });

      //KAAIVI

      db.insert('subTipo', {
        'id': 5,
        'idTipo': 196,
        'nombre': '2 PUERTAS + 2 FIJOS',
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_1_m.jpg',
        'url': 31,
      });
      db.insert('subTipo', {
        'id': 6,
        'idTipo': 196,
        'nombre': 'FRONTAL 1 PUERTA ENTRE PAREDES',
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_1_m.jpg',
        'url': 31,
      });
      db.insert('subTipo', {
        'id': 7,
        'idTipo': 196,
        'nombre': 'FRONTAL 1 PUERTA + LATERAL FIJO',
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_1_m.jpg',
        'url': 31,
      });

      //Crear tabla productos con sus datos iniciales
      db.execute('CREATE TABLE producto ('
          'id INTEGER PRIMARY KEY, '
          'idTipo INTEGER, '
          'idsubTipo INTEGER, '
          'estampado INTEGER, '
          'posicion INTEGER, '
          'todos INTEGER,'
          'img TEXT, '
          'FOREIGN KEY (idTipo) REFERENCES tipo (id) ON DELETE NO ACTION ON UPDATE NO ACTION '
          ');');

      db.insert('producto', {
        'id': 1,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_600800_nordick_1_m.jpg',
      });
      db.insert('producto', {
        'id': 2,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_600800_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 3,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_600800_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 4,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_600800_nordick_4.jpg',
      });
      db.insert('producto', {
        'id': 5,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_600800_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 6,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_600800_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 7,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_600800_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 8,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_600800_blanco_4.jpg',
      });
      db.insert('producto', {
        'id': 9,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 49,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_600800_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 10,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 49,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_600800_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 11,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 49,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_600800_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 12,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 49,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_600800_negro_4.jpg',
      });
      db.insert('producto', {
        'id': 13,
        'idTipo': 1,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 1,
        'img': 'assets/so_optimus_600800_todos_5.jpg',
      });
      db.insert('producto', {
        'id': 14,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_800_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 15,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_800_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 16,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_800_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 17,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_800_blanco_4.jpg',
      });
      db.insert('producto', {
        'id': 18,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_800_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 19,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_800_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 20,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_800_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 21,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_800_negro_4.jpg',
      });
      db.insert('producto', {
        'id': 22,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_800_nordick_1.jpg',
      });
      db.insert('producto', {
        'id': 23,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_800_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 24,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_800_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 25,
        'idTipo': 2,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_800_nordick_4.jpg',
      });
      db.insert('producto', {
        'id': 26,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 27,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 28,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 29,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 30,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 31,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 32,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_nordick_1.jpg',
      });
      db.insert('producto', {
        'id': 33,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 34,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_aplique_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 35,
        'idTipo': 3,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 4,
        'todos': 1,
        'img': 'assets/so_optimus_aplique_todos_4.jpg',
      });
      db.insert('producto', {
        'id': 36,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intred_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 37,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intred_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 38,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intred_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 39,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intred_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 40,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intred_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 41,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intred_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 42,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intred_nordick_1.jpg',
      });
      db.insert('producto', {
        'id': 43,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intred_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 44,
        'idTipo': 4,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intred_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 45,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intver_nordick_1_m.jpg',
      });
      db.insert('producto', {
        'id': 46,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intver_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 47,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intver_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 48,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intver_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 49,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intver_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 50,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intver_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 51,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_intver_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 52,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_intver_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 53,
        'idTipo': 5,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_intver_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 54,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_posred_negro_1_m.jpg',
      });
      db.insert('producto', {
        'id': 55,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_posred_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 56,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_posred_negro_3.jpg',
      });
      db.insert('producto', {
        'id': 57,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_posred_negro_4.jpg',
      });
      db.insert('producto', {
        'id': 58,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_posred_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 59,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_posred_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 60,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_posred_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 61,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_posred_blanco_4.jpg',
      });
      db.insert('producto', {
        'id': 62,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_optimus_posred_nordick_1.jpg',
      });
      db.insert('producto', {
        'id': 63,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_optimus_posred_nordick_2.jpg',
      });
      db.insert('producto', {
        'id': 64,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_optimus_posred_nordick_3.jpg',
      });
      db.insert('producto', {
        'id': 65,
        'idTipo': 6,
        'idsubTipo': 0,
        'estampado': 32,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/so_optimus_posred_nordick_4.jpg',
      });

      db.insert('producto', {
        'id': 67,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_ostippo_1_m.jpg',
      });
      db.insert('producto', {
        'id': 68,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 69,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 70,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 71,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 72,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 73,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 74,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 75,
        'idTipo': 7,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_3cajones_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 76,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_600800_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 77,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_600800_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 78,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_600800_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 79,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_600800_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 80,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_600800_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 81,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_600800_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 82,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_600800_ostippo_1.jpg',
      });
      db.insert('producto', {
        'id': 83,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_600800_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 84,
        'idTipo': 8,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_600800_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 85,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_800_ostippo_1_m.jpg',
      });
      db.insert('producto', {
        'id': 613,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_800_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 86,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_800_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 87,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_800_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 88,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_800_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 89,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_800_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 90,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_800_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 91,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_800_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 614,
        'idTipo': 9,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_800_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 92,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_aplique_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 93,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_aplique_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 94,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_aplique_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 95,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_aplique_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 96,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_aplique_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 97,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_aplique_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 98,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_aplique_ostippo_1.jpg',
      });
      db.insert('producto', {
        'id': 99,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_aplique_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 100,
        'idTipo': 10,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_aplique_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 101,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intapli_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 102,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intapli_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 103,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intapli_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 104,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intapli_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 105,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intapli_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 106,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intapli_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 107,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intapli_ostippo_1.jpg',
      });
      db.insert('producto', {
        'id': 108,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intapli_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 109,
        'idTipo': 11,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intapli_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 110,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intred_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 111,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intred_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 112,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intred_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 113,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intred_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 114,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intred_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 115,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intred_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 116,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intred_ostippo_1.jpg',
      });
      db.insert('producto', {
        'id': 117,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intred_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 118,
        'idTipo': 12,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intred_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 119,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intretro_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 120,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intretro_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 121,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intretro_blanco_3.jpg',
      });
      db.insert('producto', {
        'id': 122,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intretro_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 123,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intretro_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 124,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intretro_eternity_3.jpg',
      });
      db.insert('producto', {
        'id': 125,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_attila_intretro_ostippo_1.jpg',
      });
      db.insert('producto', {
        'id': 126,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_attila_intretro_ostippo_2.jpg',
      });
      db.insert('producto', {
        'id': 127,
        'idTipo': 13,
        'idsubTipo': 0,
        'estampado': 33,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/so_attila_intretro_ostippo_3.jpg',
      });
      db.insert('producto', {
        'id': 128,
        'idTipo': 14,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1200_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 129,
        'idTipo': 14,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1200_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 130,
        'idTipo': 14,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1200_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 131,
        'idTipo': 14,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1200_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 132,
        'idTipo': 15,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1400_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 133,
        'idTipo': 15,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1400_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 134,
        'idTipo': 15,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1400_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 135,
        'idTipo': 15,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_1400_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 136,
        'idTipo': 16,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_855_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 137,
        'idTipo': 16,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_855_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 138,
        'idTipo': 16,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_855_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 139,
        'idTipo': 16,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_855_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 140,
        'idTipo': 17,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones600_caledonia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 141,
        'idTipo': 17,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones600_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 142,
        'idTipo': 17,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones600_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 143,
        'idTipo': 17,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones600_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 144,
        'idTipo': 18,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones800_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 145,
        'idTipo': 18,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones800_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 146,
        'idTipo': 18,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones800_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 147,
        'idTipo': 18,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_cajones800_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 148,
        'idTipo': 19,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco1200_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 149,
        'idTipo': 19,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco1200_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 150,
        'idTipo': 19,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco1200_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 151,
        'idTipo': 19,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco1200_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 152,
        'idTipo': 20,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco600_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 224,
        'idTipo': 20,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco600_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 153,
        'idTipo': 20,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco600_caledonia_1.jpg',
      });

      db.insert('producto', {
        'id': 154,
        'idTipo': 20,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco600_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 155,
        'idTipo': 20,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_noja_hueco600_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 156,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_1200_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 157,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_1200_gris_2.jpg',
      });
      db.insert('producto', {
        'id': 158,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_1200_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 159,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_1200_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 160,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_1200_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 161,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_1200_caledonia_2.jpg',
      });
      db.insert('producto', {
        'id': 162,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_1200_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 163,
        'idTipo': 21,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_1200_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 164,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_600_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 165,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_600_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 166,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_600_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 167,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_600_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 168,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_600_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 169,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_600_caledonia_2.jpg',
      });
      db.insert('producto', {
        'id': 170,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_600_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 171,
        'idTipo': 22,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_arenys_600_gris_2.jpg',
      });
      db.insert('producto', {
        'id': 172,
        'idTipo': 23,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_855_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 173,
        'idTipo': 23,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_855_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 174,
        'idTipo': 23,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_855_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 175,
        'idTipo': 23,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_arenys_855_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 176,
        'idTipo': 24,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_almagro_500_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 177,
        'idTipo': 24,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_almagro_500_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 178,
        'idTipo': 25,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_almagro_700_caledonia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 179,
        'idTipo': 25,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_almagro_700_caledonia_2.jpg',
      });
      db.insert('producto', {
        'id': 180,
        'idTipo': 25,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_almagro_700_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 181,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_micro_water_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 182,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_micro_water_caledonia_2.jpg',
      });
      db.insert('producto', {
        'id': 183,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_micro_water_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 184,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_micro_water_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 185,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_micro_water_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 186,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_micro_water_eternity_2.jpg',
      });
      db.insert('producto', {
        'id': 187,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_micro_water_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 188,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/so_micro_water_gris_2.jpg',
      });

      db.insert('producto', {
        'id': 189,
        'idTipo': 26,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo1_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 190,
        'idTipo': 26,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo1_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 191,
        'idTipo': 26,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo1_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 192,
        'idTipo': 27,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo2_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 193,
        'idTipo': 27,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo2_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 194,
        'idTipo': 27,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/so_pmr_ciclo2_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 195,
        'idTipo': 28,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_espejos_alcor_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 196,
        'idTipo': 29,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_espejos_loira600_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 197,
        'idTipo': 29,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/so_espejos_loira600_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 198,
        'idTipo': 29,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/so_espejos_loira600_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 199,
        'idTipo': 30,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_espejos_loira800_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 200,
        'idTipo': 30,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/so_espejos_loira800_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 201,
        'idTipo': 30,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/so_espejos_loira800_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 202,
        'idTipo': 31,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/so_espejos_schwan600_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 203,
        'idTipo': 202,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_paneles_panel_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 204,
        'idTipo': 202,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_paneles_panel_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 205,
        'idTipo': 202,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_paneles_panel_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 206,
        'idTipo': 202,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_paneles_panel_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 207,
        'idTipo': 32,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod1puerta_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 208,
        'idTipo': 32,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod1puerta_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 209,
        'idTipo': 32,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod1puerta_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 210,
        'idTipo': 32,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod1puerta_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 211,
        'idTipo': 33,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod2puertas_caledonia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 212,
        'idTipo': 33,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod2puertas_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 213,
        'idTipo': 33,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod2puertas_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 214,
        'idTipo': 33,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_mod2puertas_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 215,
        'idTipo': 33,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/so_infinity_mod2puertas_todos_1.jpg',
      });
      db.insert('producto', {
        'id': 216,
        'idTipo': 34,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar2puertas_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 217,
        'idTipo': 34,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar2puertas_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 218,
        'idTipo': 34,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar2puertas_eternity_1.jpg',
      });
      db.insert('producto', {
        'id': 219,
        'idTipo': 34,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar2puertas_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 220,
        'idTipo': 35,
        'idsubTipo': 0,
        'estampado': 16,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar4puertas_eternity_1_m.jpg',
      });
      db.insert('producto', {
        'id': 221,
        'idTipo': 35,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar4puertas_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 222,
        'idTipo': 35,
        'idsubTipo': 0,
        'estampado': 12,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar4puertas_caledonia_1.jpg',
      });
      db.insert('producto', {
        'id': 223,
        'idTipo': 35,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/so_infinity_pilar4puertas_gris_1.jpg',
      });
      db.insert('producto', {
        'id': 225,
        'idTipo': 36,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1000_fresno_1_m.jpg',
      });
      db.insert('producto', {
        'id': 226,
        'idTipo': 36,
        'idsubTipo': 0,
        'estampado': 31,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1000_nogal_1.jpg',
      });
      db.insert('producto', {
        'id': 227,
        'idTipo': 36,
        'idsubTipo': 0,
        'estampado': 38,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1000_roble_1.jpg',
      });
      db.insert('producto', {
        'id': 228,
        'idTipo': 37,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1200pure_fresno_1_m.jpg',
      });
      db.insert('producto', {
        'id': 229,
        'idTipo': 38,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1200real_fresno_1_m.jpg',
      });
      db.insert('producto', {
        'id': 230,
        'idTipo': 38,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_moment_1200real_fresno_2.jpg',
      });
      db.insert('producto', {
        'id': 231,
        'idTipo': 39,
        'idsubTipo': 0,
        'estampado': 31,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1370intense_nogal_1_m.jpg',
      });
      db.insert('producto', {
        'id': 232,
        'idTipo': 39,
        'idsubTipo': 0,
        'estampado': 31,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_moment_1370intense_nogal_2.jpg',
      });
      db.insert('producto', {
        'id': 233,
        'idTipo': 40,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1490pure_fresno_1_m.jpg',
      });
      db.insert('producto', {
        'id': 234,
        'idTipo': 40,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_moment_1490pure_fresno_2.jpg',
      });
      db.insert('producto', {
        'id': 235,
        'idTipo': 40,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_or_moment_1490pure_fresno_3.jpg',
      });
      db.insert('producto', {
        'id': 236,
        'idTipo': 41,
        'idsubTipo': 0,
        'estampado': 38,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_1600real_roble_1_m.jpg',
      });
      db.insert('producto', {
        'id': 237,
        'idTipo': 41,
        'idsubTipo': 0,
        'estampado': 38,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_moment_1600real_roble_2.jpg',
      });
      db.insert('producto', {
        'id': 238,
        'idTipo': 42,
        'idsubTipo': 0,
        'estampado': 31,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_2000intense_nogal_1_m.jpg',
      });
      db.insert('producto', {
        'id': 239,
        'idTipo': 42,
        'idsubTipo': 0,
        'estampado': 31,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_moment_2000intense_nogal_2.jpg',
      });
      db.insert('producto', {
        'id': 240,
        'idTipo': 44,
        'idsubTipo': 0,
        'estampado': 17,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_moment_600pure_fresno_1_m.jpg',
      });
      db.insert('producto', {
        'id': 241,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_antracita_1_m.jpg',
      });
      db.insert('producto', {
        'id': 242,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 243,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 244,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 245,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 246,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 247,
        'idTipo': 49,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000antracita_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 248,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_bosquegreen_1_m.jpg',
      });
      db.insert('producto', {
        'id': 249,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_bosquegreen_2.jpg',
      });
      db.insert('producto', {
        'id': 250,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 251,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_antracita_2.jpg',
      });
      db.insert('producto', {
        'id': 252,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 253,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_blanco_2.jpg',
      });
      db.insert('producto', {
        'id': 254,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 255,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_bluefog_2.jpg',
      });
      db.insert('producto', {
        'id': 256,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 257,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_macchiato_2.jpg',
      });
      db.insert('producto', {
        'id': 258,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 259,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 260,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 261,
        'idTipo': 50,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1000gf_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 262,
        'idTipo': 51,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1370nb_nightblue_1_m.jpg',
      });
      db.insert('producto', {
        'id': 263,
        'idTipo': 51,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1370nb_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 264,
        'idTipo': 52,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_1600bf_bluefog_1_m.jpg',
      });
      db.insert('producto', {
        'id': 265,
        'idTipo': 46,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600bv_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 266,
        'idTipo': 46,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600bv_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 267,
        'idTipo': 46,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600bv_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 268,
        'idTipo': 46,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600bv_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 269,
        'idTipo': 46,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600bv_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 270,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_blancomate_1_m.jpg',
      });
      db.insert('producto', {
        'id': 271,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 272,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 273,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 274,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 275,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 276,
        'idTipo': 45,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_600wc_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 277,
        'idTipo': 48,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800m_macchiato_1_m.jpg',
      });
      db.insert('producto', {
        'id': 278,
        'idTipo': 48,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800m_macchiato_2.jpg',
      });
      db.insert('producto', {
        'id': 279,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_blancomate_1_m.jpg',
      });
      db.insert('producto', {
        'id': 281,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_blancomate_2.jpg',
      });
      db.insert('producto', {
        'id': 282,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 283,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_antracita_2.jpg',
      });
      db.insert('producto', {
        'id': 284,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 285,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_bluefog_2.jpg',
      });
      db.insert('producto', {
        'id': 286,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 287,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_bosquegreen_2.jpg',
      });
      db.insert('producto', {
        'id': 288,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 289,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_macchiato_2.jpg',
      });
      db.insert('producto', {
        'id': 615,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 290,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_negro_2.jpg',
      });
      db.insert('producto', {
        'id': 291,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 292,
        'idTipo': 47,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 293,
        'idTipo': 53,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200bv_negro_1_m.jpg',
      });
      db.insert('producto', {
        'id': 294,
        'idTipo': 53,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200bv_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 295,
        'idTipo': 53,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200bv_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 296,
        'idTipo': 53,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200bv_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 297,
        'idTipo': 54,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200nb_nightblue_1_m.jpg',
      });
      db.insert('producto', {
        'id': 298,
        'idTipo': 54,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200nb_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 299,
        'idTipo': 55,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200wc_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 300,
        'idTipo': 55,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_mam_1200wc_whitecotton_2.jpg',
      });
      db.insert('producto', {
        'id': 301,
        'idTipo': 56,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1500antracita_antracita_1_m.jpg',
      });
      db.insert('producto', {
        'id': 302,
        'idTipo': 56,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_mam_1500antracita_antracita_2.jpg',
      });
      db.insert('producto', {
        'id': 303,
        'idTipo': 57,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_1500l_macchiato_1_m.jpg',
      });
      db.insert('producto', {
        'id': 304,
        'idTipo': 58,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bf_bluefog_1_m.jpg',
      });
      db.insert('producto', {
        'id': 305,
        'idTipo': 58,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bf_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 306,
        'idTipo': 58,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bf_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 307,
        'idTipo': 58,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bf_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 308,
        'idTipo': 58,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bf_nightblue_1.jpg',
      });

      db.insert('producto', {
        'id': 309,
        'idTipo': 59,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bv_negro_1_m.jpg',
      });
      db.insert('producto', {
        'id': 310,
        'idTipo': 59,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bv_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 311,
        'idTipo': 59,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bv_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 312,
        'idTipo': 59,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bv_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 313,
        'idTipo': 59,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900bv_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 314,
        'idTipo': 60,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900i_bosquegreen_1_m.jpg',
      });
      db.insert('producto', {
        'id': 315,
        'idTipo': 60,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900i_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 316,
        'idTipo': 61,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900wc_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 317,
        'idTipo': 61,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900wc_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 318,
        'idTipo': 61,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_mam_900wc_bosquegreen_1.jpg',
      });

      db.insert('producto', {
        'id': 319,
        'idTipo': 70,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200a_antracita_1_m.jpg',
      });
      db.insert('producto', {
        'id': 320,
        'idTipo': 70,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200a_antracita_2.jpg',
      });
      db.insert('producto', {
        'id': 321,
        'idTipo': 70,
        'idsubTipo': 0,
        'estampado': 47,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200a_terracota_1.jpg',
      });

      db.insert('producto', {
        'id': 322,
        'idTipo': 69,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200n_nata_1_m.jpg',
      });
      db.insert('producto', {
        'id': 616,
        'idTipo': 71,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200ni_nightblue_1_m.jpg',
      });
      db.insert('producto', {
        'id': 323,
        'idTipo': 71,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_1200ni_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 324,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_blancomate_1_m.jpg',
      });
      db.insert('producto', {
        'id': 325,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 50,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_almendra_1.jpg',
      });
      db.insert('producto', {
        'id': 326,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 327,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 4,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_azulaltamar_1.jpg',
      });
      db.insert('producto', {
        'id': 328,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_bluefog_1.jpg',
      });
      db.insert('producto', {
        'id': 329,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 330,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 13,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_castano_1.jpg',
      });
      db.insert('producto', {
        'id': 331,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 15,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_cielo_1.jpg',
      });
      db.insert('producto', {
        'id': 332,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 18,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_granate_1.jpg',
      });
      db.insert('producto', {
        'id': 333,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 21,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_humo_1.jpg',
      });
      db.insert('producto', {
        'id': 334,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 335,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 336,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 337,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 338,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 34,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_paja_1.jpg',
      });
      db.insert('producto', {
        'id': 339,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 40,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_rojo_1.jpg',
      });
      db.insert('producto', {
        'id': 340,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 41,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_royalgreen_1.jpg',
      });
      db.insert('producto', {
        'id': 341,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 42,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_salvia_1.jpg',
      });
      db.insert('producto', {
        'id': 342,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 43,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_sol_1.jpg',
      });
      db.insert('producto', {
        'id': 343,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 44,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_taupe_1.jpg',
      });
      db.insert('producto', {
        'id': 609,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 47,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_terracota_1.jpg',
      });
      db.insert('producto', {
        'id': 344,
        'idTipo': 62,
        'idsubTipo': 0,
        'estampado': 45,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_600_verdeacido_1.jpg',
      });
      db.insert('producto', {
        'id': 345,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_bluefog_1_m.jpg',
      });
      db.insert('producto', {
        'id': 350,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_bluefog_2.jpg',
      });
      db.insert('producto', {
        'id': 346,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 50,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_almendra_1.jpg',
      });
      db.insert('producto', {
        'id': 347,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 348,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 4,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_azulaltamar_1.jpg',
      });
      db.insert('producto', {
        'id': 349,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 351,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 352,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 13,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_castano_1.jpg',
      });
      db.insert('producto', {
        'id': 353,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 15,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_cielo_1.jpg',
      });
      db.insert('producto', {
        'id': 354,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 18,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_granate_1.jpg',
      });
      db.insert('producto', {
        'id': 355,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 21,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_humo_1.jpg',
      });
      db.insert('producto', {
        'id': 356,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_macchiato_1.jpg',
      });
      db.insert('producto', {
        'id': 357,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 358,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 359,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_nightblue_1.jpg',
      });
      db.insert('producto', {
        'id': 360,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 34,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_paja_1.jpg',
      });
      db.insert('producto', {
        'id': 361,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 40,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_rojo_1.jpg',
      });
      db.insert('producto', {
        'id': 362,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 41,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_royalgreen_1.jpg',
      });
      db.insert('producto', {
        'id': 363,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 42,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_salvia_1.jpg',
      });
      db.insert('producto', {
        'id': 364,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 43,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_sol_1.jpg',
      });
      db.insert('producto', {
        'id': 365,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 44,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_taupe_1.jpg',
      });
      db.insert('producto', {
        'id': 366,
        'idTipo': 65,
        'idsubTipo': 0,
        'estampado': 45,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800_verdeacido_1.jpg',
      });
      db.insert('producto', {
        'id': 367,
        'idTipo': 64,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800bs_bosquesalvia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 368,
        'idTipo': 63,
        'idsubTipo': 0,
        'estampado': 47,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_800tr_terracota_1_m.jpg',
      });
      db.insert('producto', {
        'id': 369,
        'idTipo': 67,
        'idsubTipo': 0,
        'estampado': 41,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900g_royalgreen_1_m.jpg',
      });
      db.insert('producto', {
        'id': 370,
        'idTipo': 67,
        'idsubTipo': 0,
        'estampado': 41,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900g_royalgreen_2.jpg',
      });
      db.insert('producto', {
        'id': 371,
        'idTipo': 66,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900i_bluefog_1_m.jpg',
      });
      db.insert('producto', {
        'id': 372,
        'idTipo': 66,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900i_bluefog_2.jpg',
      });
      db.insert('producto', {
        'id': 373,
        'idTipo': 68,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900n_negro_1_m.jpg',
      });
      db.insert('producto', {
        'id': 374,
        'idTipo': 68,
        'idsubTipo': 0,
        'estampado': 47,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_uniiq_900n_terracota_1.jpg',
      });

      db.insert('producto', {
        'id': 375,
        'idTipo': 72,
        'idsubTipo': 0,
        'estampado': 5,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1300_bali_1_m.jpg',
      });
      db.insert('producto', {
        'id': 376,
        'idTipo': 73,
        'idsubTipo': 0,
        'estampado': 20,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1400_havana_1_m.jpg',
      });
      db.insert('producto', {
        'id': 377,
        'idTipo': 74,
        'idsubTipo': 0,
        'estampado': 24,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1400ma_marmol_1_m.jpg',
      });
      db.insert('producto', {
        'id': 378,
        'idTipo': 75,
        'idsubTipo': 0,
        'estampado': 5,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600_bali_1_m.jpg',
      });
      db.insert('producto', {
        'id': 379,
        'idTipo': 76,
        'idsubTipo': 0,
        'estampado': 14,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600ce_cemento_1_m.jpg',
      });
      db.insert('producto', {
        'id': 380,
        'idTipo': 77,
        'idsubTipo': 0,
        'estampado': 25,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600mar_marmolblanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 381,
        'idTipo': 77,
        'idsubTipo': 0,
        'estampado': 25,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600mar_marmolblanco_2.jpg',
      });
      db.insert('producto', {
        'id': 382,
        'idTipo': 77,
        'idsubTipo': 0,
        'estampado': 25,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600mar_marmolblanco_3.jpg',
      });
      db.insert('producto', {
        'id': 383,
        'idTipo': 78,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 384,
        'idTipo': 78,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1600ro_robleafrica_2.jpg',
      });
      db.insert('producto', {
        'id': 385,
        'idTipo': 79,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1750_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 386,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 20,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_havana_1_m.jpg',
      });
      db.insert('producto', {
        'id': 387,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 5,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_bali_1.jpg',
      });
      db.insert('producto', {
        'id': 388,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 14,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_cemento_1.jpg',
      });
      db.insert('producto', {
        'id': 389,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 24,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_marmol_1.jpg',
      });
      db.insert('producto', {
        'id': 390,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 35,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_piedragris_1.jpg',
      });
      db.insert('producto', {
        'id': 391,
        'idTipo': 80,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 392,
        'idTipo': 201,
        'idsubTipo': 0,
        'estampado': 20,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_1800h_havana_1_m.jpg',
      });
      db.insert('producto', {
        'id': 393,
        'idTipo': 81,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_2000_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 394,
        'idTipo': 82,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_2180_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 395,
        'idTipo': 83,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_600_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 396,
        'idTipo': 83,
        'idsubTipo': 0,
        'estampado': 19,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_compakt_600_gris_1_m.jpg',
      });
      db.insert('producto', {
        'id': 397,
        'idTipo': 84,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_cambiobanera_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 398,
        'idTipo': 84,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_cambiobanera_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 399,
        'idTipo': 84,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_cambiobanera_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 400,
        'idTipo': 84,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 1,
        'img': 'assets/cg_mo_medida_cambiobanera_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 401,
        'idTipo': 85,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_ganaalmacenajebano_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 402,
        'idTipo': 85,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_ganaalmacenajebano_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 403,
        'idTipo': 85,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_ganaalmacenajebano_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 404,
        'idTipo': 86,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_nuevoestilo_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 405,
        'idTipo': 86,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_nuevoestilo_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 406,
        'idTipo': 86,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_nuevoestilo_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 407,
        'idTipo': 87,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_preparatubano_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 408,
        'idTipo': 87,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_preparatubano_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 409,
        'idTipo': 87,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_preparatubano_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 410,
        'idTipo': 88,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_sacapartido_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 411,
        'idTipo': 88,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_sacapartido_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 412,
        'idTipo': 88,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_sacapartido_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 413,
        'idTipo': 89,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_solucionaproblemas_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 414,
        'idTipo': 89,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_solucionaproblemas_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 415,
        'idTipo': 89,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_solucionaproblemas_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 416,
        'idTipo': 90,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 1,
        'img': 'assets/cg_mo_medida_transformacuarto_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 417,
        'idTipo': 90,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 1,
        'img': 'assets/cg_mo_medida_transformacuarto_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 418,
        'idTipo': 90,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 1,
        'img': 'assets/cg_mo_medida_transformacuarto_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 419,
        'idTipo': 90,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 1,
        'img': 'assets/cg_mo_medida_transformacuarto_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 420,
        'idTipo': 91,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000bv_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 421,
        'idTipo': 92,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000p_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 422,
        'idTipo': 92,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000p_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 423,
        'idTipo': 92,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000p_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 424,
        'idTipo': 92,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000p_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 425,
        'idTipo': 92,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000p_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 426,
        'idTipo': 93,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 427,
        'idTipo': 93,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000ro_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 428,
        'idTipo': 93,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1000ro_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 429,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 430,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 431,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 432,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 433,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 434,
        'idTipo': 94,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200al_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 435,
        'idTipo': 95,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200b_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 436,
        'idTipo': 95,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200b_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 437,
        'idTipo': 96,
        'idsubTipo': 0,
        'estampado': 10,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200bl_bluefog_1_m.jpg',
      });
      db.insert('producto', {
        'id': 438,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 439,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 440,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_natural_3.jpg',
      });
      db.insert('producto', {
        'id': 441,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_natural_4.jpg',
      });
      db.insert('producto', {
        'id': 442,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 443,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 444,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 445,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 446,
        'idTipo': 97,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1200na_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 447,
        'idTipo': 98,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1210_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 448,
        'idTipo': 99,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1390i_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 449,
        'idTipo': 100,
        'idsubTipo': 0,
        'estampado': 23,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1400ma_macchiato_1_m.jpg',
      });
      db.insert('producto', {
        'id': 450,
        'idTipo': 101,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1400nb_nightblue_1_m.jpg',
      });
      db.insert('producto', {
        'id': 451,
        'idTipo': 101,
        'idsubTipo': 0,
        'estampado': 30,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1400nb_nightblue_2.jpg',
      });
      db.insert('producto', {
        'id': 452,
        'idTipo': 102,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1400wc_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 453,
        'idTipo': 202,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1500pb_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 454,
        'idTipo': 103,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1500ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 455,
        'idTipo': 103,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1500ro_robleafrica_2.jpg',
      });
      db.insert('producto', {
        'id': 456,
        'idTipo': 103,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1500ro_robleafrica_3.jpg',
      });
      db.insert('producto', {
        'id': 457,
        'idTipo': 104,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1600i_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 458,
        'idTipo': 105,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_1710_bosquegreen_1_m.jpg',
      });
      db.insert('producto', {
        'id': 459,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 460,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 461,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_blancobrillo_1.jpg',
      });
      db.insert('producto', {
        'id': 462,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 11,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_bosquegreen_1.jpg',
      });
      db.insert('producto', {
        'id': 463,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 464,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 465,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 466,
        'idTipo': 106,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_monterrey_800_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 467,
        'idTipo': 107,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000al_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 468,
        'idTipo': 107,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000al_alsacia_2.jpg',
      });
      db.insert('producto', {
        'id': 469,
        'idTipo': 108,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000d_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 470,
        'idTipo': 108,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000d_whitecotton_2.jpg',
      });
      db.insert('producto', {
        'id': 471,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 472,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 473,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 474,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 475,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 477,
        'idTipo': 109,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1000na_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 478,
        'idTipo': 110,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1090i_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 479,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 480,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 481,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 482,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 483,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 484,
        'idTipo': 111,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 485,
        'idTipo': 112,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200i_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 486,
        'idTipo': 113,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 487,
        'idTipo': 113,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1200na_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 488,
        'idTipo': 114,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1400_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 489,
        'idTipo': 114,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1400_robleafrica_2.jpg',
      });
      db.insert('producto', {
        'id': 490,
        'idTipo': 115,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1400i_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 491,
        'idTipo': 116,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1500_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 492,
        'idTipo': 116,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1500_whitecotton_2.jpg',
      });
      db.insert('producto', {
        'id': 493,
        'idTipo': 117,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1600_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 494,
        'idTipo': 118,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1600ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 495,
        'idTipo': 119,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1800_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 496,
        'idTipo': 119,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_1800_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 497,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_blancobrillo_1_m.jpg',
      });
      db.insert('producto', {
        'id': 498,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 499,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 500,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 501,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 503,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 504,
        'idTipo': 120,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700bb_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 505,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 506,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 507,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 508,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 509,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 510,
        'idTipo': 121,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_700pb_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 617,
        'idTipo': 122,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800bv_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 608,
        'idTipo': 122,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800bv_blackvelvet_2.jpg',
      });
      db.insert('producto', {
        'id': 512,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 513,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 514,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 515,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 516,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 517,
        'idTipo': 123,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_spirit_800ro_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 518,
        'idTipo': 124,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_or_renoir_800wc_blancomate_1_m.jpg',
      });
      db.insert('producto', {
        'id': 519,
        'idTipo': 125,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1000d_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 520,
        'idTipo': 125,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1000d_alsacia_2.jpg',
      });
      db.insert('producto', {
        'id': 522,
        'idTipo': 126,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1200bv_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 523,
        'idTipo': 127,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1200c_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 524,
        'idTipo': 127,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1200c_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 525,
        'idTipo': 128,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1200d_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 526,
        'idTipo': 129,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1200na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 527,
        'idTipo': 130,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1400_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 528,
        'idTipo': 131,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1400c_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 529,
        'idTipo': 131,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1400c_pinobahia_2.jpg',
      });
      db.insert('producto', {
        'id': 530,
        'idTipo': 131,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1400c_pinobahia_3.jpg',
      });
      db.insert('producto', {
        'id': 531,
        'idTipo': 132,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1500_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 532,
        'idTipo': 133,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1700_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 533,
        'idTipo': 133,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1700_robleafrica_2.jpg',
      });
      db.insert('producto', {
        'id': 534,
        'idTipo': 133,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1700_robleafrica_3.jpg',
      });
      db.insert('producto', {
        'id': 535,
        'idTipo': 133,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_1700_robleafrica_4.jpg',
      });
      db.insert('producto', {
        'id': 536,
        'idTipo': 134,
        'idsubTipo': 0,
        'estampado': 46,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_600_whitecotton_1_m.jpg',
      });
      db.insert('producto', {
        'id': 537,
        'idTipo': 134,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_600_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 538,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 539,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 540,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 541,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 26,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_nata_1.jpg',
      });
      db.insert('producto', {
        'id': 542,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 543,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 544,
        'idTipo': 135,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 545,
        'idTipo': 136,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_700bv_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 546,
        'idTipo': 137,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_800_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 547,
        'idTipo': 137,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_800_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 548,
        'idTipo': 138,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 549,
        'idTipo': 138,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900_blackvelvet_2.jpg',
      });
      db.insert('producto', {
        'id': 550,
        'idTipo': 138,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900_blackvelvet_3.jpg',
      });
      db.insert('producto', {
        'id': 551,
        'idTipo': 139,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900d_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 552,
        'idTipo': 139,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900d_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 553,
        'idTipo': 140,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900i_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 554,
        'idTipo': 142,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_900iro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 555,
        'idTipo': 141,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_fussion_doble1400_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 556,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 557,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 558,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_blancobrillo_1.jpg',
      });
      db.insert('producto', {
        'id': 559,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_blancomate_1.jpg',
      });
      db.insert('producto', {
        'id': 560,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 561,
        'idTipo': 143,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500ro_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 562,
        'idTipo': 144,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35500wc_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 563,
        'idTipo': 145,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35700bv_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 564,
        'idTipo': 146,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35700na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 565,
        'idTipo': 147,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_35700pb_pinobahia_2.jpg',
      });
      db.insert('producto', {
        'id': 566,
        'idTipo': 148,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40500al_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 567,
        'idTipo': 149,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40500ro_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 568,
        'idTipo': 150,
        'idsubTipo': 0,
        'estampado': 6,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700bv_blackvelvet_1_m.jpg',
      });
      db.insert('producto', {
        'id': 569,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_natural_1_m.jpg',
      });
      db.insert('producto', {
        'id': 570,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 571,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 572,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 573,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 574,
        'idTipo': 151,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700na_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 575,
        'idTipo': 152,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_40700wc_blanco_1_m.jpg',
      });
      db.insert('producto', {
        'id': 576,
        'idTipo': 153,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_marthaal_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 577,
        'idTipo': 153,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_marthaal_alsacia_2.jpg',
      });
      db.insert('producto', {
        'id': 578,
        'idTipo': 154,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_martharo_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 579,
        'idTipo': 154,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_reducido_martharo_robleafrica_2.jpg',
      });
      db.insert('producto', {
        'id': 580,
        'idTipo': 155,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1hueco_robleafrica_1_m.jpg',
      });
      db.insert('producto', {
        'id': 581,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 582,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 3,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_antracita_1.jpg',
      });
      db.insert('producto', {
        'id': 583,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 584,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_blancomate_1.jpg',
      });
      db.insert('producto', {
        'id': 585,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 586,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_natural_2.jpg',
      });
      db.insert('producto', {
        'id': 587,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 588,
        'idTipo': 156,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puerta_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 589,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_alsacia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 590,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_alsacia_2.jpg',
      });
      db.insert('producto', {
        'id': 591,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 1,
        'todos': 0,
        'img':
            'assets/cg_mo_auxiliares_coqueta1puertaasuelo_blancobrillo_1.jpg',
      });
      db.insert('producto', {
        'id': 592,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_blancomate_1.jpg',
      });
      db.insert('producto', {
        'id': 593,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 594,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 595,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 596,
        'idTipo': 157,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_coqueta1puertaasuelo_robleafrica_1.jpg',
      });
      db.insert('producto', {
        'id': 597,
        'idTipo': 166,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_pilar_pinobahia_1_m.jpg',
      });
      db.insert('producto', {
        'id': 598,
        'idTipo': 166,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_pilar_pinobahia_2.jpg',
      });
      db.insert('producto', {
        'id': 599,
        'idTipo': 166,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_pilar_pinobahia_2.jpg',
      });
      db.insert('producto', {
        'id': 600,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_blancobrillo_1_m.jpg',
      });
      db.insert('producto', {
        'id': 601,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_blancobrillo_2.jpg',
      });
      db.insert('producto', {
        'id': 602,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 8,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_blancobrillo_2.jpg',
      });
      db.insert('producto', {
        'id': 603,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 604,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 9,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_blancomate_1.jpg',
      });
      db.insert('producto', {
        'id': 605,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 27,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_natural_1.jpg',
      });
      db.insert('producto', {
        'id': 606,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_negro_1.jpg',
      });
      db.insert('producto', {
        'id': 607,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 36,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_pinobahia_1.jpg',
      });
      db.insert('producto', {
        'id': 610,
        'idTipo': 167,
        'idsubTipo': 0,
        'estampado': 39,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_semipilar_robleafrica_1.jpg',
      });

      //CG MO AUXILIAR TOCADOR
      db.insert('producto', {
        'id': 618,
        'idTipo': 168,
        'idsubTipo': 0,
        'estampado': 2,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_tocador_alsacia_1.jpg',
      });
      db.insert('producto', {
        'id': 619,
        'idTipo': 168,
        'idsubTipo': 0,
        'estampado': 7,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_tocador_blanco_1.jpg',
      });
      db.insert('producto', {
        'id': 620,
        'idTipo': 168,
        'idsubTipo': 0,
        'estampado': 28,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mo_auxiliares_tocador_negro_1.jpg',
      });

      //CG LAVABOS

      //Lavabos

      //MAM
      db.insert('producto', {
        'id': 621,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 622,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 623,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 624,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 625,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 626,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 627,
        'idTipo': 169,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_900derrebosadero_nocolor_7.jpg',
      });

      //ALLIANCE

      db.insert('producto', {
        'id': 628,
        'idTipo': 170,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_alliance_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 629,
        'idTipo': 170,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_alliance_nocolor_2.jpg',
      });

      //CONSTANZA

      db.insert('producto', {
        'id': 630,
        'idTipo': 171,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_contanza_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 631,
        'idTipo': 171,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_contanza_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 632,
        'idTipo': 171,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_contanza_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 633,
        'idTipo': 171,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_contanza_nocolor_4.jpg',
      });

      //DE POSAR

      db.insert('producto', {
        'id': 634,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 635,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 636,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 637,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 638,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 639,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 640,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 641,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 642,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_9.jpg',
      });
      db.insert('producto', {
        'id': 643,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 10,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_10.jpg',
      });
      db.insert('producto', {
        'id': 644,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 11,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_11.jpg',
      });
      db.insert('producto', {
        'id': 645,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 12,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_12.jpg',
      });
      db.insert('producto', {
        'id': 646,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 13,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_13.jpg',
      });
      db.insert('producto', {
        'id': 647,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 14,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_14.jpg',
      });
      db.insert('producto', {
        'id': 648,
        'idTipo': 172,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 15,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_deposar_nocolor_15.jpg',
      });

      //MAEL

      db.insert('producto', {
        'id': 649,
        'idTipo': 173,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_mael_nocolor_1.jpg',
      });

      db.insert('producto', {
        'id': 650,
        'idTipo': 173,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_mael_nocolor_2.jpg',
      });

      //MARTHA

      db.insert('producto', {
        'id': 651,
        'idTipo': 174,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_martha_nocolor_1.jpg',
      });

      //S35

      db.insert('producto', {
        'id': 652,
        'idTipo': 175,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_s35_nocolor_1.jpg',
      });

      //S40

      db.insert('producto', {
        'id': 653,
        'idTipo': 176,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_s40_nocolor_1.jpg',
      });

      //TOSCANA

      db.insert('producto', {
        'id': 654,
        'idTipo': 177,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_toscana_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 655,
        'idTipo': 177,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_toscana_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 656,
        'idTipo': 177,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_toscana_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 657,
        'idTipo': 177,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_toscana_nocolor_4.jpg',
      });

      //UNIIQ

      db.insert('producto', {
        'id': 658,
        'idTipo': 178,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_uniiq_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 659,
        'idTipo': 178,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_uniiq_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 660,
        'idTipo': 178,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_uniiq_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 661,
        'idTipo': 178,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_uniiq_nocolor_4.jpg',
      });

      //VENETO

      db.insert('producto', {
        'id': 662,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 663,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 664,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 665,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 666,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 667,
        'idTipo': 179,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_veneto_nocolor_6.jpg',
      });

      //VILNA

      db.insert('producto', {
        'id': 668,
        'idTipo': 180,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 669,
        'idTipo': 180,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 670,
        'idTipo': 180,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 671,
        'idTipo': 180,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 672,
        'idTipo': 180,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_lavabo_vilna_nocolor_5.jpg',
      });

      //ESPEJOS Y APLIQUES

      //Apliques

      db.insert('producto', {
        'id': 673,
        'idTipo': 181,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 674,
        'idTipo': 181,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 675,
        'idTipo': 181,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 676,
        'idTipo': 181,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 677,
        'idTipo': 181,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_apliques_nocolor_5.jpg',
      });

      //Espejos

      db.insert('producto', {
        'id': 678,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 679,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 680,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 681,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 682,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 683,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 684,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 685,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 686,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_9.jpg',
      });
      db.insert('producto', {
        'id': 687,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 10,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_10.jpg',
      });
      db.insert('producto', {
        'id': 688,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 11,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_11.jpg',
      });
      db.insert('producto', {
        'id': 689,
        'idTipo': 182,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 12,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejosyapliques_espejos_nocolor_12.jpg',
      });

      //ESPEJOS Y ACCESORIOS

      //LLOYD

      db.insert('producto', {
        'id': 690,
        'idTipo': 183,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 691,
        'idTipo': 183,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 692,
        'idTipo': 183,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 693,
        'idTipo': 183,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 694,
        'idTipo': 183,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_lloyd_nocolor_5.jpg',
      });

      //NILO

      db.insert('producto', {
        'id': 695,
        'idTipo': 184,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_nilo_nocolor_1.jpg',
      });

      //OBI

      db.insert('producto', {
        'id': 696,
        'idTipo': 185,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_obi_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 697,
        'idTipo': 185,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_obi_nocolor_2.jpg',
      });

      //SHIRO

      db.insert('producto', {
        'id': 698,
        'idTipo': 186,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_shiro_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 699,
        'idTipo': 186,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_shiro_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 700,
        'idTipo': 186,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_shiro_nocolor_3.jpg',
      });

      //SOLID SURFACE

      db.insert('producto', {
        'id': 701,
        'idTipo': 187,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_solidsurface_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 702,
        'idTipo': 187,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_lavabos_espejoyaccesorios_solidsurface_nocolor_2.jpg',
      });

      //PLATOS DE DUCHA
      db.insert('producto', {
        'id': 703,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 704,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 705,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 706,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 707,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 708,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 709,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 710,
        'idTipo': 188,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_universoducha_ducha_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 711,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 712,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 713,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 714,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 715,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 716,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 717,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 718,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 719,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_9.jpg',
      });
      db.insert('producto', {
        'id': 720,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 10,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_10.jpg',
      });
      db.insert('producto', {
        'id': 721,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 11,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_11.jpg',
      });
      db.insert('producto', {
        'id': 722,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 12,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_12.jpg',
      });
      db.insert('producto', {
        'id': 723,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 13,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_13.jpg',
      });
      db.insert('producto', {
        'id': 724,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 14,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_14.jpg',
      });
      db.insert('producto', {
        'id': 725,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 15,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_15.jpg',
      });
      db.insert('producto', {
        'id': 726,
        'idTipo': 203,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 16,
        'todos': 0,
        'img': 'assets/cg_mamparas_pasosyfijos_heaven_nocolor_16.jpg',
      });
      db.insert('producto', {
        'id': 728,
        'idTipo': 192,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_clear_nocolor_1_1_m.jpg',
      });
      db.insert('producto', {
        'id': 729,
        'idTipo': 192,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_clear_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 730,
        'idTipo': 192,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_clear_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 731,
        'idTipo': 192,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_clear_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 732,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img':
            'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_1_2_m.jpg',
      });
      db.insert('producto', {
        'id': 733,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 734,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 735,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 736,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 737,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 738,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 739,
        'idTipo': 193,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_puertascorrederas_copenhage_nocolor_8.jpg',
      });

      //HELSINKI SUBTIPOS

      //FRONTAL 1

      db.insert('producto', {
        'id': 740,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 741,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 742,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 743,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 744,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 745,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 746,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 747,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 748,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_9.jpg',
      });
      db.insert('producto', {
        'id': 749,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 10,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_10.jpg',
      });
      db.insert('producto', {
        'id': 750,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 11,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_11.jpg',
      });
      db.insert('producto', {
        'id': 752,
        'idTipo': 194,
        'idsubTipo': 1,
        'estampado': 0,
        'posicion': 12,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal1_nocolor_12.jpg',
      });

      //FRONTAL 2

      db.insert('producto', {
        'id': 753,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 754,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 755,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 756,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 757,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 758,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 759,
        'idTipo': 194,
        'idsubTipo': 2,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_frontal2_nocolor_7.jpg',
      });

      //FRONTAL 1 LATERAL

      db.insert('producto', {
        'id': 760,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 761,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 762,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 763,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 764,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 765,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 766,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 767,
        'idTipo': 194,
        'idsubTipo': 3,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral1_nocolor_8.jpg',
      });

      //FRONTAL 2 LATERAL

      db.insert('producto', {
        'id': 768,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 769,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 770,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 771,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 772,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 773,
        'idTipo': 194,
        'idsubTipo': 4,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_helsinki_lateral2_nocolor_6.jpg',
      });

      //KAAIVI SUBTIPOS

      //2PUERTAS

      db.insert('producto', {
        'id': 774,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 775,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 776,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 777,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 778,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 779,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 780,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 781,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 782,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_9.jpg',
      });
      db.insert('producto', {
        'id': 783,
        'idTipo': 195,
        'idsubTipo': 5,
        'estampado': 0,
        'posicion': 10,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_2puertas_nocolor_10.jpg',
      });

      //FRONTAL

      db.insert('producto', {
        'id': 784,
        'idTipo': 195,
        'idsubTipo': 6,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 785,
        'idTipo': 195,
        'idsubTipo': 6,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 786,
        'idTipo': 195,
        'idsubTipo': 6,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 787,
        'idTipo': 195,
        'idsubTipo': 6,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 788,
        'idTipo': 195,
        'idsubTipo': 6,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_frontal_nocolor_5.jpg',
      });

      //LATERAL FIJO

      db.insert('producto', {
        'id': 789,
        'idTipo': 195,
        'idsubTipo': 7,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_1.jpg',
      });
      db.insert('producto', {
        'id': 790,
        'idTipo': 195,
        'idsubTipo': 7,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 791,
        'idTipo': 195,
        'idsubTipo': 7,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 792,
        'idTipo': 195,
        'idsubTipo': 7,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 793,
        'idTipo': 195,
        'idsubTipo': 7,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_kaaivi_lateralfijo_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 794,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 795,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 796,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 797,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 798,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 799,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 800,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 801,
        'idTipo': 197,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_habitat_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 802,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 803,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 804,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 805,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 806,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 807,
        'idTipo': 198,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_malmo_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 808,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 809,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 810,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 811,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 812,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 813,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 814,
        'idTipo': 199,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_odense_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 815,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 1,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_1_m.jpg',
      });
      db.insert('producto', {
        'id': 816,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 2,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_2.jpg',
      });
      db.insert('producto', {
        'id': 817,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 3,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_3.jpg',
      });
      db.insert('producto', {
        'id': 818,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 4,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_4.jpg',
      });
      db.insert('producto', {
        'id': 819,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 5,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_5.jpg',
      });
      db.insert('producto', {
        'id': 820,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 6,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_6.jpg',
      });
      db.insert('producto', {
        'id': 821,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 7,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_7.jpg',
      });
      db.insert('producto', {
        'id': 822,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 8,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_8.jpg',
      });
      db.insert('producto', {
        'id': 823,
        'idTipo': 200,
        'idsubTipo': 0,
        'estampado': 0,
        'posicion': 9,
        'todos': 0,
        'img': 'assets/cg_mamparas_abatibles_vitte_nocolor_9.jpg',
      });
      db.execute('''
  CREATE TABLE Url (
    id INTEGER PRIMARY KEY,
    idTipo INTEGER,
    url_es TEXT,
    url_en TEXT,
    url_fr TEXT,
    FOREIGN KEY (idTipo) REFERENCES tipo (id) ON DELETE NO ACTION ON UPDATE NO ACTION
  );
''');
// Insertar la familia "catalogo"
      db.insert('Url', {
        'id': 1,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/catalogos-salgar',
        'url_en': 'https://www.salgar.net/en/salgar-catalogues-uk',
        'url_fr': 'https://www.salgar.net/fr/catalogues-salgar-fr',
      });

// Insertar la familia "quienessomos"
      db.insert('Url', {
        'id': 2,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/fabricante-muebles-de-bano',
        'url_en': 'https://www.salgar.net/en/company-salgar',
        'url_fr': 'https://www.salgar.net/fr/societe-salgar',
      });

// Insertar la familia "showroom"
      db.insert('Url', {
        'id': 3,
        'idTipo': null,
        'url_es': 'https://my.matterport.com/show/?m=nnH8asG6wVf',
        'url_en': 'https://my.matterport.com/show/?m=FMSZmrhV6Rn',
        'url_fr': 'https://my.matterport.com/show/?m=EUeVAuLFFst',
      });

// Insertar la familia "contacto"
      db.insert('Url', {
        'id': 4,
        'idTipo': null,
        'url_es':
            'https://soporte.salgar.net/hc/es/requests/new?ticket_form_id=5056564400657',
        'url_en':
            'https://soporte.salgar.net/hc/en-gb/requests/new?ticket_form_id=5056564400657',
        'url_fr':
            'https://soporte.salgar.net/hc/fr/requests/new?ticket_form_id=5056564400657',
      });

// Insertar la familia "inicio"
      db.insert('Url', {
        'id': 5,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/muebles-de-bano-es',
        'url_en': 'https://www.salgar.net/en/furniture-en',
        'url_fr': 'https://www.salgar.net/fr/meubles-salle-bain-fr',
      });

// Insertar la familia "materiales"
      db.insert('Url', {
        'id': 6,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/materiales-y-acabados',
        'url_en': 'https://www.salgar.net/en/materials-finishes',
        'url_fr': 'https://www.salgar.net/fr/materiaux-finitions',
      });

// Insertar la familia "superofertas"
      db.insert('Url', {
        'id': 7,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/conjuntos-muebles-ba%C3%B1o',
        'url_en': 'https://www.salgar.net/en/sets',
        'url_fr': 'https://www.salgar.net/fr/ensembles',
      });

// Insertar la familia "moment"
      db.insert('Url', {
        'id': 8,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/moment-4375',
        'url_en': 'https://www.salgar.net/en/moment-6181',
        'url_fr': 'https://www.salgar.net/fr/moment-5013',
      });

// Insertar la familia "optimus"
      db.insert('Url', {
        'id': 9,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/optimus-6822',
        'url_en': 'https://www.salgar.net/en/optimus-4616',
        'url_fr': 'https://www.salgar.net/fr/optimus-5664',
      });
// Insertar la familia "renoir"
      db.insert('Url', {
        'id': 10,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/renoir-4934',
        'url_en': 'https://www.salgar.net/en/renoir-4764',
        'url_fr': 'https://www.salgar.net/fr/renoir-7842',
      });

// Insertar la familia "attila"
      db.insert('Url', {
        'id': 11,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/serie-attila',
        'url_en': 'https://www.salgar.net/en/attila-7826',
        'url_fr': 'https://www.salgar.net/fr/attila-1619',
      });

// Insertar la familia "compakt"
      db.insert('Url', {
        'id': 12,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/compakt-es',
        'url_en': 'https://www.salgar.net/en/complet-set-noja',
        'url_fr': 'https://www.salgar.net/fr/compakt-fr',
      });

// Insertar la familia "noja"
      db.insert('Url', {
        'id': 13,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/conjunto-completo-noja',
        'url_en': 'https://www.salgar.net/en/complet-set-noja',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-noja',
      });

// Insertar la familia "mam"
      db.insert('Url', {
        'id': 14,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-mam',
        'url_en': 'https://www.salgar.net/en/basin-mam',
        'url_fr': 'https://www.salgar.net/fr/vasque-mam',
      });

// Insertar la familia "arenys"
      db.insert('Url', {
        'id': 15,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/conjunto-completo-arenys',
        'url_en': 'https://www.salgar.net/en/uniiq-inspiration-en',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-arenys',
      });

// Insertar la familia "uniiq"
      db.insert('Url', {
        'id': 16,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/uniiq-inspiracion-es',
        'url_en': 'https://www.salgar.net/en/uniiq-en',
        'url_fr': 'https://www.salgar.net/fr/uniiq-inspiration-fr',
      });

// Insertar la familia "almagro"
      db.insert('Url', {
        'id': 17,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/almagro-5289',
        'url_en': 'https://www.salgar.net/en/almagro-6286',
        'url_fr': 'https://www.salgar.net/fr/almagro-6940',
      });

// Insertar la familia "vinci"
      db.insert('Url', {
        'id': 18,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/vinci-es',
        'url_en': 'https://www.salgar.net/en/complet-set-micro',
        'url_fr': 'https://www.salgar.net/fr/vinci-fr',
      });

// Insertar la familia "micro"
      db.insert('Url', {
        'id': 19,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/conjunto-completo-micro',
        'url_en': 'https://www.salgar.net/en/complet-set-micro',
        'url_fr': 'https://www.salgar.net/fr/ensemble-complet-fr-micro',
      });

// Insertar la familia "monterrey"
      db.insert('Url', {
        'id': 20,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/monterrey-inspiracion',
        'url_en': 'https://www.salgar.net/en/monterrey-inspiration',
        'url_fr': 'https://www.salgar.net/fr/monterrey-inspiration-fr',
      });
// Insertar la familia "pmr"
      db.insert('Url', {
        'id': 21,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/personas-movilidad-reducida',
        'url_en': 'https://www.salgar.net/en/people-reduced-mobility',
        'url_fr': 'https://www.salgar.net/fr/personnes-mobilite-reduite',
      });

// Insertar la familia "spirit"
      db.insert('Url', {
        'id': 22,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/spirit-inspiracion-es',
        'url_en': 'https://www.salgar.net/en/spirit-inspiration-en',
        'url_fr': 'https://www.salgar.net/fr/meuble-salle-bain-spirit',
      });

// Insertar la familia "fussionline"
      db.insert('Url', {
        'id': 23,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/fussion-line-es',
        'url_en': 'https://www.salgar.net/en/fussion-line-en',
        'url_fr': 'https://www.salgar.net/fr/fussion-line-fr',
      });

// Insertar la familia "fussionlinef35"
      db.insert('Url', {
        'id': 24,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/s35-inspiracion-es',
        'url_en': 'https://www.salgar.net/en/s35-inspiration-en',
        'url_fr': 'https://www.salgar.net/fr/s35-inspiration-fr',
      });

// Insertar la familia "fussionlinef40"
      db.insert('Url', {
        'id': 25,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/s40-7758',
        'url_en': 'https://www.salgar.net/en/s40-1438',
        'url_fr': 'https://www.salgar.net/fr/s40-6385',
      });

// Insertar la familia "martha"
      db.insert('Url', {
        'id': 26,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/martha-inspiracion',
        'url_en': 'https://www.salgar.net/en/martha-inspiration',
        'url_fr': 'https://www.salgar.net/fr/martha-inspiration-fr',
      });

// Insertar la familia "lavabos"
      db.insert('Url', {
        'id': 27,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabos-integrados',
        'url_en': 'https://www.salgar.net/en/integrated-washbasins',
        'url_fr': 'https://www.salgar.net/fr/lavabos-integres',
      });

// Insertar la familia "espejos"
      db.insert('Url', {
        'id': 28,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/espejos-es',
        'url_en': 'https://www.salgar.net/es/mirrors-en',
        'url_fr': 'https://www.salgar.net/fr/miroirs-fr',
      });

// Insertar la familia "accesorios"
      db.insert('Url', {
        'id': 29,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/accesorios',
        'url_en': 'https://www.salgar.net/en/accessories',
        'url_fr': 'https://www.salgar.net/fr/accesoires',
      });

// Insertar la familia "mamparas"
      db.insert('Url', {
        'id': 30,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/espacio-mampara-2023',
        'url_en': 'https://www.salgar.net/en/espacio-mampara-en',
        'url_fr': 'https://www.salgar.net/fr/monde-douche-salgar-2023',
      });

// Insertar la familia "correderas"
      db.insert('Url', {
        'id': 31,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/correderas',
        'url_en': 'https://www.salgar.net/en/sliding-screens',
        'url_fr': 'https://www.salgar.net/fr/pliant',
      });
      
// Insertar la familia "puertasbisagra"
      db.insert('Url', {
        'id': 32,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/puertas-de-bisagra',
        'url_en': 'https://www.salgar.net/en/hinge-doors',
        'url_fr': 'https://www.salgar.net/fr/charniere',
      });

// Insertar la familia "depasofija"
      db.insert('Url', {
        'id': 33,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/de-paso-o-fija',
        'url_en': 'https://www.salgar.net/en/hinged',
        'url_fr': 'https://www.salgar.net/fr/ouverte',
      });

// Insertar la familia "soespejos"
      db.insert('Url', {
        'id': 34,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/espejos-sunset',
        'url_en': 'https://www.salgar.net/en/mirrors-sunset',
        'url_fr': 'https://www.salgar.net/fr/miroirs-sunset',
      });

// Insertar la familia "armarios"
      db.insert('Url', {
        'id': 35,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/armarios-so',
        'url_en': 'https://www.salgar.net/en/cabinets-so',
        'url_fr': 'https://www.salgar.net/fr/armoires-so',
      });

// Insertar la familia "paneles"
      db.insert('Url', {
        'id': 36,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/panel-de-ducha-684-gris-mate',
        'url_en': 'https://www.salgar.net/en/bath-panel-684-matt-grey',
        'url_fr': 'https://www.salgar.net/fr/bath-panel-684-gris-mat',
      });

// Insertar la familia "infinity"
      db.insert('Url', {
        'id': 37,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/pilares-so',
        'url_en': 'https://www.salgar.net/en/pillars-so',
        'url_fr': 'https://www.salgar.net/fr/piliers-so',
      });

// Insertar la familia "serieoriginal"
      db.insert('Url', {
        'id': 38,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/series-original-salgar',
        'url_en': 'https://www.salgar.net/en/series-original-salgar-en',
        'url_fr': 'https://www.salgar.net/fr/serie-originale-salgar',
      });

// Insertar la familia "modular"
      db.insert('Url', {
        'id': 39,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/series-modulares-salgar',
        'url_en': 'https://www.salgar.net/en/modular-salgar',
        'url_fr': 'https://www.salgar.net/fr/serie-modulaire-salgar',
      });

// Insertar la familia "medida"
      db.insert('Url', {
        'id': 40,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/series-modulares-salgar',
        'url_en': 'https://www.salgar.net/en/modular-salgar',
        'url_fr': 'https://www.salgar.net/fr/serie-modulaire-salgar',
      });
// Insertar la familia "auxiliares"
      db.insert('Url', {
        'id': 41,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/auxiliares',
        'url_en': 'https://www.salgar.net/en/auxiliary',
        'url_fr': 'https://www.salgar.net/fr/auxiliarires',
      });

// Insertar la familia "constanza"
      db.insert('Url', {
        'id': 42,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-constanza',
        'url_en': 'https://www.salgar.net/en/basin-constanza',
        'url_fr': 'https://www.salgar.net/fr/vasque-constanza',
      });

// Insertar la familia "veneto"
      db.insert('Url', {
        'id': 43,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-veneto',
        'url_en': 'https://www.salgar.net/en/basin-veneto',
        'url_fr': 'https://www.salgar.net/fr/vasque-veneto',
      });

// Insertar la familia "toscana"
      db.insert('Url', {
        'id': 44,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-toscana',
        'url_en': 'https://www.salgar.net/en/basin-toscana',
        'url_fr': 'https://www.salgar.net/fr/vasque-toscana',
      });

// Insertar la familia "vilna"
      db.insert('Url', {
        'id': 45,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-vilna-605-1poza',
        'url_en': 'https://www.salgar.net/en/basin-vilna-605-1-basin',
        'url_fr': 'https://www.salgar.net/fr/vasque-vilna-605-1vasque',
      });

// Insertar la familia "alliance"
      db.insert('Url', {
        'id': 46,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-alliance-bano',
        'url_en': 'https://www.salgar.net/en/lavabo-alliance-bano-en',
        'url_fr': 'https://www.salgar.net/fr/vasques-alliance-salle-bain',
      });

// Insertar la familia "deposar"
      db.insert('Url', {
        'id': 47,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabos-de-posar',
        'url_en': 'https://www.salgar.net/en/countertop-basin',
        'url_fr': 'https://www.salgar.net/fr/vasque-a-poser',
      });

// Insertar la familia "aplique"
      db.insert('Url', {
        'id': 48,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/apliques',
        'url_en': 'https://www.salgar.net/en/lights',
        'url_fr': 'https://www.salgar.net/fr/appliques',
      });
// Insertar la familia "lloyd"
      db.insert('Url', {
        'id': 49,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/accesorios-bano-lloyd',
        'url_en': 'https://www.salgar.net/en/accesorios-bano-lloyd-en',
        'url_fr': 'https://www.salgar.net/fr/accesories-salle-bain-lloyd',
      });

// Insertar la familia "abatibles"
      db.insert('Url', {
        'id': 50,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/puertas-de-bisagra',
        'url_en': 'https://www.salgar.net/en/hinge-doors',
        'url_fr': 'https://www.salgar.net/fr/charniere',
      });

// Insertar la familia "platos"
      db.insert('Url', {
        'id': 51,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/platos-de-ducha-y-columnas',
        'url_en': 'https://www.salgar.net/en/shower-trays-and-shower-columns',
        'url_fr':
            'https://www.salgar.net/fr/receveurs-de-douche-colonnes-hydromassage-ensemble-de-douche',
      });

// Insertar la familia "columnas"
      db.insert('Url', {
        'id': 52,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/columnas-de-ducha',
        'url_en': 'https://www.salgar.net/en/shower-columns',
        'url_fr': 'https://www.salgar.net/fr/colonnes-de-douche',
      });

// Insertar la familia "s35"
      db.insert('Url', {
        'id': 53,
        'idTipo': null,
        'url_es':
            'https://www.salgar.net/es/lavabo-s35-610-extraplano-porcelana-blanca-610-x-20-x-360-mm',
        'url_en':
            'https://www.salgar.net/en/basin-s35-610-superfine-white-porcelain-610-x-20-x-360-mm',
        'url_fr':
            'https://www.salgar.net/fr/vasque-s35-610-en-porcelaine-blanche-610-x-20-x-360-mm',
      });

// Insertar la familia "s40"
      db.insert('Url', {
        'id': 54,
        'idTipo': null,
        'url_es':
            'https://www.salgar.net/es/lavabo-fondo-40-iberia-510-porcelana-blanca-510-x-20-x-395-mm',
        'url_en':
            'https://www.salgar.net/basin-depth-40-iberia-510-white-porcelain-510-x-20-x-395-mm',
        'url_fr':
            'https://www.salgar.net/vasque-fond-40-iberia-510-en-porcelaine-blanche-510-x-20-x-395-mm',
      });

// Insertar la familia "lespejos"
      db.insert('Url', {
        'id': 55,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/espejos-es',
        'url_en': 'https://www.salgar.net/en/mirrors-en',
        'url_fr': 'https://www.salgar.net/fr/miroirs-fr',
      });

// Insertar la familia "eaccesorio"
      db.insert('Url', {
        'id': 56,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/accesorios-es',
        'url_en': 'https://www.salgar.net/en/accessories-en',
        'url_fr': 'https://www.salgar.net/fr/accesoires-fr',
      });
// Insertar la familia "lavabo-uniiq"
      db.insert('Url', {
        'id': 57,
        'idTipo': null,
        'url_es': 'https://www.salgar.net/es/lavabo-uniiq',
        'url_en': 'https://www.salgar.net/en/basin-uniiq',
        'url_fr': 'https://www.salgar.net/fr/vasque-uniiq',
      });
    }, version: 1);

    return database;
  }

//Recoger listado de catalogos
  static Future<List<Catalogo>> catalogos() async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> catalogosMap = await db.query("catalogos");

    return List.generate(
        catalogosMap.length,
        (index) => Catalogo(
            id: catalogosMap[index]['id'],
            nombre: catalogosMap[index]['nombre'],
            img: catalogosMap[index]['img'],
            title_es: catalogosMap[index]['title_es'],
            title_en: catalogosMap[index]['title_en'],
            title_fr: catalogosMap[index]['title_fr'],
            url_es: catalogosMap[index]['url_es'],
            url_en: catalogosMap[index]['url_en'],
            url_fr: catalogosMap[index]['url_fr']));
  }

//Recoger listado de series
  static Future<List<Serie>> series() async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> seriesMap = await db.query("series");

    return List.generate(
        seriesMap.length,
        (index) => Serie(
            id: seriesMap[index]['id'],
            idCatalogo: seriesMap[index]['idCatalogo'],
            nombre: seriesMap[index]['nombre'],
            img: seriesMap[index]['img'],
            title_es: seriesMap[index]['title_es'],
            title_en: seriesMap[index]['title_en'],
            title_fr: seriesMap[index]['title_fr'],
            url_es: seriesMap[index]['url_es'],
            url_en: seriesMap[index]['url_en'],
            url_fr: seriesMap[index]['url_fr']));
  }

//Recoger listado de superofertas principales
  static Future<List<Gama>> soMain() async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showCatalogoMainMap = await db.query(
      'gama',
      where: 'idCatalogo = ?',
      whereArgs: [2],
      limit: 4,
    );

    return List.generate(
        showCatalogoMainMap.length,
        (index) => Gama(
            id: showCatalogoMainMap[index]['id'],
            idCatalogo: showCatalogoMainMap[index]['idCatalogo'],
            nombre: showCatalogoMainMap[index]['nombre'],
            img: showCatalogoMainMap[index]['img'],
            title_es: showCatalogoMainMap[index]['title_es'],
            title_en: showCatalogoMainMap[index]['title_en'],
            title_fr: showCatalogoMainMap[index]['title_fr'],
            url_es: showCatalogoMainMap[index]['url_es'],
            url_en: showCatalogoMainMap[index]['url_en'],
            url_fr: showCatalogoMainMap[index]['url_fr']));
  }

//Recoger listado de superofertas completo
  static Future<List<Gama>> soCompleted() async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showCatalogoMap = await db.query('gama',
        where: 'idCatalogo = ?', whereArgs: [2], offset: 4);

    return List.generate(
        showCatalogoMap.length,
        (index) => Gama(
            id: showCatalogoMap[index]['id'],
            idCatalogo: showCatalogoMap[index]['idCatalogo'],
            nombre: showCatalogoMap[index]['nombre'],
            img: showCatalogoMap[index]['img'],
            title_es: showCatalogoMap[index]['title_es'],
            title_en: showCatalogoMap[index]['title_en'],
            title_fr: showCatalogoMap[index]['title_fr'],
            url_es: showCatalogoMap[index]['url_es'],
            url_en: showCatalogoMap[index]['url_en'],
            url_fr: showCatalogoMap[index]['url_fr']));
  }

  //Recoger listado de gamas del cg segun la serie que le pasamos
  static Future<List<Gama>> gamasSeries(nombreSerie) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showCatalogoMap = await db.query(
      'gama',
      where:
          'idCatalogo = ? AND idSerie IN (SELECT id FROM series WHERE nombre = ?)',
      whereArgs: [1, nombreSerie],
    );

    return List.generate(
        showCatalogoMap.length,
        (index) => Gama(
            id: showCatalogoMap[index]['id'],
            idCatalogo: showCatalogoMap[index]['idCatalogo'],
            idSerie: showCatalogoMap[index]['idSerie'],
            nombre: showCatalogoMap[index]['nombre'],
            img: showCatalogoMap[index]['img'],
            title_es: showCatalogoMap[index]['title_es'],
            title_en: showCatalogoMap[index]['title_en'],
            title_fr: showCatalogoMap[index]['title_fr'],
            url_es: showCatalogoMap[index]['url_es'],
            url_en: showCatalogoMap[index]['url_en'],
            url_fr: showCatalogoMap[index]['url_fr']));
  }

  //Recoger listado de gamas del cg segun la serie que le pasamos
  static Future<List<TipoProducto>> tipos(nombreGama) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showTiposMap = await db.query(
      'tipo',
      where: 'idGama IN (SELECT id FROM gama WHERE nombre = ?)',
      whereArgs: [nombreGama],
    );

    return List.generate(
        showTiposMap.length,
        (index) => TipoProducto(
              id: showTiposMap[index]['id'],
              idGama: showTiposMap[index]['idGama'],
              nombre: showTiposMap[index]['nombre'],
              img: showTiposMap[index]['img'],
              url: showTiposMap[index]['url'],
            ));
  }

  // Recoger listado de subTipos segun el tipo que le pasamos
  static Future<List<subTipo>> subTipos(int idTipo) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showSubTiposMap = await db.query(
      'subTipo',
      where: 'idTipo = ?',
      whereArgs: [idTipo],
    );

    return List.generate(
        showSubTiposMap.length,
        (index) => subTipo(
              id: showSubTiposMap[index]['id'],
              idTipo: showSubTiposMap[index]['idTipo'],
              nombre: showSubTiposMap[index]['nombre'],
              img: showSubTiposMap[index]['img'],
              url: showSubTiposMap[index]['url'],
            ));
  }

  // Recoger listado de productos segun el tipo que le pasamos
  static Future<List<Producto>> productos(int idTipo) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> showSubTiposMap = await db.query(
      'producto',
      where: 'idTipo = ?',
      whereArgs: [idTipo],
    );

    return List.generate(
      showSubTiposMap.length,
      (index) => Producto(
        id: showSubTiposMap[index]['id'],
        idTipo: showSubTiposMap[index]['idTipo'],
        idsubTipo: showSubTiposMap[index]['idsubTipo'],
        estampado: showSubTiposMap[index]['estampado'],
        posicion: showSubTiposMap[index]['posicion'],
        todos: showSubTiposMap[index]['todos'],
        img: showSubTiposMap[index]['img'],
      ),
    );
  }

//CARGAR ESTAMPADO DESDE LA BD
  static Future<Estampado> getEstampadoFromDB(int id) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'estampado',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Estampado(
        id: maps[0]['id'],
        img: maps[0]['img'],
      );
    } else {
      throw Exception('ID $id not found');
    }
  }

  //CARGAR LISTA DE ESTAMPADOS
  static Future<Set<Estampado>> getEstampadosFromProductos(int idTipo) async {
    Database db = await _openDB();

    // Primero, obtener los productos
    final List<Map<String, dynamic>> productoMaps = await db.query(
      'producto',
      where: 'idTipo = ?',
      whereArgs: [idTipo],
    );

    // Convertir los mapas de productos a objetos Producto
    List<Producto> productos = productoMaps
        .map((productoMap) => Producto(
              id: productoMap['id'],
              idTipo: productoMap['idTipo'],
              idsubTipo: productoMap['idsubTipo'],
              estampado: productoMap['estampado'],
              posicion: productoMap['posicion'],
              todos: productoMap['todos'],
              img: productoMap['img'],
            ))
        .toList();

    // Obtener los estampados únicos a partir de los productos
    Set<Estampado> estampados = {};

    for (Producto producto in productos) {
      if (producto.estampado != 0) {
        Estampado estampado = await getEstampadoFromDB(producto.estampado);

        estampados.add(estampado);
      }
    }

    return estampados;
  }

  //Cargar productos desde el id del subtipo
  static Future<List<Producto>> productosPorSubTipo(int idsubTipo) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> productosMap = await db.query(
      'producto',
      where: 'idsubTipo = ?',
      whereArgs: [idsubTipo],
    );

    return List.generate(
        productosMap.length,
        (index) => Producto(
              id: productosMap[index]['id'],
              idTipo: productosMap[index]['idTipo'],
              idsubTipo: productosMap[index]['idsubTipo'],
              estampado: productosMap[index]['estampado'],
              posicion: productosMap[index]['posicion'],
              todos: productosMap[index]['todos'],
              img: productosMap[index]['img'],
            ));
  }

  // Cargar URLs desde el id del tipo
  static Future<List<Url>> urlsPorTipo(int id) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> urlsMap = await db.query(
      'Url',
      where: 'id = ?',
      whereArgs: [id],
    );

    return List.generate(
        urlsMap.length,
        (index) => Url(
              id: urlsMap[index]['id'],
              idTipo: urlsMap[index]['idTipo'],
              url_es: urlsMap[index]['url_es'],
              url_en: urlsMap[index]['url_en'],
              url_fr: urlsMap[index]['url_fr'],
            ));
  }

// Función para cargar un catálogo específico por nombre
  static Future<Catalogo> cargarCatalogoPorNombre(String nombre) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> catalogoMap =
        await db.query("catalogos", where: "nombre = ?", whereArgs: [nombre]);

    return Catalogo(
        id: catalogoMap[0]['id'],
        nombre: catalogoMap[0]['nombre'],
        img: catalogoMap[0]['img'],
        title_es: catalogoMap[0]['title_es'],
        title_en: catalogoMap[0]['title_en'],
        title_fr: catalogoMap[0]['title_fr'],
        url_es: catalogoMap[0]['url_es'],
        url_en: catalogoMap[0]['url_en'],
        url_fr: catalogoMap[0]['url_fr']);
  }

// Función para cargar una serie específica por nombre
  static Future<Serie> cargarSeriePorNombre(String nombre) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> serieMap =
        await db.query("series", where: "nombre = ?", whereArgs: [nombre]);

    return Serie(
        id: serieMap[0]['id'],
        idCatalogo: serieMap[0]['idCatalogo'],
        nombre: serieMap[0]['nombre'],
        img: serieMap[0]['img'],
        title_es: serieMap[0]['title_es'],
        title_en: serieMap[0]['title_en'],
        title_fr: serieMap[0]['title_fr'],
        url_es: serieMap[0]['url_es'],
        url_en: serieMap[0]['url_en'],
        url_fr: serieMap[0]['url_fr']);
  }
}
