import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:salgar2023/classes/classes.dart';

class CardSwiper extends StatelessWidget {
  final Function() onCatalogoSelected; // Función para notificar la selección de un catálogo
  final Function(String) onSwipe; // Function to notify the swipe event


  const CardSwiper({Key? key, required this.onCatalogoSelected, required this.onSwipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<List<Catalogo>>(
      future: DB.catalogos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final catalogos = snapshot.data;

          return SizedBox(
            width: double.infinity,
            height: size.height * 0.8,
            child: Swiper(
              itemCount: catalogos!.length,
              layout: SwiperLayout.STACK,
              itemWidth: size.width * 0.8,
              itemHeight: double.infinity,
              onIndexChanged: (int index) {
                onSwipe(catalogos[index].nombre); // Notify the swipe event
              },
              itemBuilder: (_, int index) {
                final catalogo = catalogos[index];
                return GestureDetector(
                  onTap: () {
                    onCatalogoSelected(); 
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ClipRRect(
                            child: FadeInImage(
                              placeholder: const NetworkImage(
                                  'https://via.placeholder.com/300x400'),
                              image: AssetImage(catalogo.img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los catálogos');
        }

        // Muestra un indicador de carga mientras se obtienen los datos
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
