import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class CamaraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Launcher Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Launcher Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Verificar si la aplicación está instalada
              bool isInstalled = await LaunchApp.isAppInstalled(
                androidPackageName: 'com.macrovideo.v380pro',
              );

              if (isInstalled) {
                // Abrir la aplicación si está instalada
                await LaunchApp.openApp(
                  androidPackageName: 'com.macrovideo.v380pro',
                );
              } else {
                // Si no está instalada, abrir la Play Store
                await LaunchApp.openApp(
                  androidPackageName: 'com.macrovideo.v380pro',
                );
              }
            },
            child: Text('Abrir V380 Pro'),
          ),
        ),
      ),
    );
  }
}
