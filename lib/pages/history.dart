import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistorialDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Historial de concentraciones',style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sensor')
            .doc('metano')
            .collection('unique_id')
            .orderBy('timestamp',
                descending: true) // Ordena por marca de tiempo descendente
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.white)),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No hay datos disponibles',style: TextStyle(color: Colors.white)),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Obtener el dato en la posición actual
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                // Convertir el timestamp a un objeto DateTime
                var timestampString = data['timestamp'] as String;
                var timestamp = DateTime.parse(timestampString);
                // Formatear la fecha
                var formattedDate = DateFormat('yyyy-MM-dd').format(timestamp);
                // Obtener el valor
                var valor = data['value'];
                return ListTile(
                  title: Text('Fecha: $formattedDate',style: TextStyle(color: Colors.white)),
                  subtitle: Text('Valor: $valor',style: TextStyle(color: Colors.white)),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HistorialDatos(),
  ));
}
