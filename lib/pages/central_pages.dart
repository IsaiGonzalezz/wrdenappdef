import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warden_techsecure/pages/chatIA_page.dart';
import 'package:warden_techsecure/pages/emergencia.dart';
import 'package:warden_techsecure/providers/dashboard.dart';
import 'package:warden_techsecure/pages/home_page.dart';
import 'package:android_intent_plus/android_intent.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({Key? key}) : super(key: key);

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Center(
          child:
              Text('Warden Tech-Secure', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 60.0), // Añade espacio en la parte superior
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 1, 250, 9), // Color del borde
                      width: 4.0, // Ancho del borde
                    ),
                    boxShadow: [
                      // Agrega sombra para dar un efecto de brillo
                      BoxShadow(
                        color: const Color.fromARGB(255, 1, 250, 9),
                        blurRadius:
                            30.0, // Ajusta el radio de desenfoque para cambiar cuánto brillo deseas
                        spreadRadius:
                            2.0, // Ajusta el radio de propagación para cambiar cuánto brillo deseas
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('assets/wardenLogo.jpeg'),
                  ),
                ),
              ),
            ],
          ),

          Divider(height: 60.0, color: Colors.black),
          SizedBox(
              height: 110.0,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centra los botones horizontalmente
                children: [
                  Container(
                    width: 120, // Ancho del botón
                    height:
                        140, // Altura del botón, aumentada para acomodar el texto
                    decoration: BoxDecoration(
                      color: Colors.black, // Color de fondo del botón
                      borderRadius:
                          BorderRadius.circular(20), // Esquinas redondeadas
                      border: Border.all(
                        color: Colors.white, // Color del borde
                        width: 3.0, // Ancho del borde
                      ),
                      boxShadow: [
                        // donde se agrega sombra para dar un efecto de brillo
                        BoxShadow(
                          color: const Color.fromARGB(255, 217, 3, 255),
                          blurRadius:
                              20.0, // aqui se justa el radio de desenfoque para cambiar cuánto brillo
                          spreadRadius:
                              5.0, // aqui se justa el radio de propagación para cambiar cuánto brillo
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.web,
                              color: Colors.white, size: 60), // Ícono de casa
                          onPressed: () {
                            launch('https://warden-eight.vercel.app/');
                          },
                        ),
                        Text('Sitio Web',
                            style: TextStyle(
                                color: Colors.white)), // Texto debajo del botón
                      ],
                    ),
                  ),

                  SizedBox(width: 50), // Espacio entre botones
                  Container(
                    width: 120, // Ancho del botón
                    height:
                        140, // Altura del botón, aumentada para acomodar el texto
                    decoration: BoxDecoration(
                      color: Colors.black, // Color de fondo del botón
                      borderRadius:
                          BorderRadius.circular(20), // Esquinas redondeadas
                      border: Border.all(
                        color: Colors.white, // Color del borde
                        width: 3.0, // Ancho del borde
                      ),
                      boxShadow: [
                        // Agrega sombra para dar un efecto de brillo
                        BoxShadow(
                          color: Colors.pink,
                          blurRadius:
                              20.0, // Ajusta el radio de desenfoque para cambiar cuánto brillo deseas
                          spreadRadius:
                              5.0, // Ajusta el radio de propagación para cambiar cuánto brillo deseas
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 60), // Ícono de persona
                          onPressed: () async {
                            final AndroidIntent intent = AndroidIntent(
                              action: 'action_view',
                              data:
                                  'v380pro://', // Esquema de URL para abrir la app V380 Pro
                              package:
                                  'com.macrovideo.v380pro', // Nombre del paquete de la app V380 Pro
                            );

                            final bool? isAppnInstalled =
                                await intent.canResolveActivity();

                            if (isAppnInstalled != null && isAppnInstalled) {
                              await intent
                                  .launch(); // Intenta abrir la app V380 Pro
                            } else {
                              final AndroidIntent playStoreIntent =
                                  AndroidIntent(
                                action: 'action_view',
                                data:
                                    'https://play.google.com/store/apps/details?id=com.macrovideo.v380pro', // URL de la Play Store para descargar la app V380 Pro
                              );
                              await playStoreIntent
                                  .launch(); // Si no está instalada, abre la Play Store
                            }
                          },
                        ),
                        Text('Cámaras',
                            style: TextStyle(
                                color: Colors.white)), // Texto debajo del botón
                      ],
                    ),
                  ),
                ],
              )),
          //DIVIDER
          Divider(height: 40.0, color: Colors.black),
          SizedBox(
              height: 110.0,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centra los botones horizontalmente
                children: [
                  Container(
                    width: 120, // Ancho del botón
                    height:
                        140, // Altura del botón, aumentada para acomodar el texto
                    decoration: BoxDecoration(
                      color: Colors.black, // Color de fondo del botón
                      borderRadius:
                          BorderRadius.circular(20), // Esquinas redondeadas
                      border: Border.all(
                        color: Colors.white, // Color del borde
                        width: 3.0, // Ancho del borde
                      ),
                      boxShadow: [
                        // Agrega sombra para dar un efecto de brillo
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 243, 170),
                          blurRadius:
                              20.0, // Ajusta el radio de desenfoque para cambiar cuánto brillo deseas
                          spreadRadius:
                              5.0, // Ajusta el radio de propagación para cambiar cuánto brillo deseas
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.sensors,
                              color: Colors.white, size: 60), // Ícono de casa
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                        ),
                        Text('Sensores',
                            style: TextStyle(
                                color: Colors.white)), // Texto debajo del botón
                      ],
                    ),
                  ),

                  SizedBox(width: 50), // Espacio entre botones

                  Container(
                    width: 120, // Ancho del botón
                    height:
                        140, // Altura del botón, aumentada para acomodar el texto
                    decoration: BoxDecoration(
                      color: Colors.black, // Color de fondo del botón
                      borderRadius:
                          BorderRadius.circular(20), // Esquinas redondeadas
                      border: Border.all(
                        color: Colors.white, // Color del borde
                        width: 3.0, // Ancho del borde
                      ),
                      boxShadow: [
                        // Agrega sombra para dar un efecto de brillo
                        BoxShadow(
                          color: Colors.yellow,
                          blurRadius:
                              20.0, // Ajusta el radio de desenfoque para cambiar cuánto brillo deseas
                          spreadRadius:
                              5.0, // Ajusta el radio de propagación para cambiar cuánto brillo deseas
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.contact_emergency_outlined,
                              color: Colors.white,
                              size: 60), // Ícono de persona
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EmergencyServicesButtons()),
                            );
                          },
                        ),
                        Text('Emergencia',
                            style: TextStyle(
                                color: Colors.white)), // Texto debajo del botón
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
            switch (selectedIndex) {
              case 0:
                // Navigate to Chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatIA()),
                );
                break;
              case 1:
                // Navigate to Home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
            }
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.exit_to_app),
            label: 'Salir',
          ),
        ],
      ),
    );
  }
}
