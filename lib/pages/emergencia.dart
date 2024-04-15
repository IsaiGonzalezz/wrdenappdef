import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmergencyServicesPage(),
    );
  }
}

class EmergencyServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Servicios de Emergencia',
          style: TextStyle(color: Colors.black), // Cambia el color del texto
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // Cambia el color del icono
        ),
        backgroundColor: Colors.white, // Cambia el color de fondo de la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: EmergencyServicesButtons(),
    );
  }
}

class EmergencyServicesButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: <Widget>[
          ServiceButton(
            icon: Icons.local_hospital,
            label: 'Hospital',
            phoneNumber: 'tel:+524272642307',
          ),
          ServiceButton(
            icon: Icons.local_police,
            label: 'Policía',
            phoneNumber: '11',
          ),
          ServiceButton(
            icon: Icons.local_fire_department,
            label: 'Bomberos',
            phoneNumber: '11',
          ),
          ServiceButton(
            icon: Icons.support_agent,
            label: 'Soporte',
            phoneNumber: '123456789',
          ),
        ],
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String phoneNumber;

  const ServiceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      onPressed: () => _launchPhoneCall(context, phoneNumber),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 36),
          Text(
            label,
            style: TextStyle(color: Colors.black), // Cambia el color del texto
          ),
        ],
      ),
    );
  }

  void _launchPhoneCall(BuildContext context, String phoneNumber) async {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneCallUri.toString())) {
      await launch(phoneCallUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo realizar la llamada a $phoneNumber'),
        ),
      );
    }
  }
}
