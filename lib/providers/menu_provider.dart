import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MenuProvider {
  List<dynamic> opciones = [];

  MenuProvider() {}

  Future<List<dynamic>> cargarOpciones() async {
    final resp = await rootBundle.loadString('assets/menu_opts.json');
    Map opcionesMap = json.decode(resp);
    opciones = opcionesMap['rutas'];

    return opciones;
  }
}

final menuProvider = new MenuProvider();
