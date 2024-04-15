import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:warden_techsecure/pages/history.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Concentraciones de gas',style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialDatos()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance
            .collection('sensor')
            .doc('metano')
            .collection('unique_id')
            .orderBy('timestamp', descending: true)
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
            // Obtener los datos de Firestore
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            // Mapear los datos a DateTime y valor
            List<DateTime> dates = [];
            List<double> values = [];
            documents.forEach((doc) {
              var data = doc.data() as Map<String, dynamic>;
              var timestampString = data['timestamp'] as String;
              var timestamp = DateTime.parse(timestampString);
              dates.add(timestamp);
              values.add(data['value']
                  as double); // Asegúrate de que 'valor' sea un número
            });

            // Construir el gráfico
            return LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 100,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        //lógica para mostrar los títulos del eje X
                        var index = value.toInt();
                        if (index >= 0 && index < dates.length) {
                          var date = dates[index];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4.0, // Ajusta el espacio según sea necesario
                            child: Text(DateFormat('dd/MM').format(date),
                            style: TextStyle(color: Colors.white)),
                          );
                        } else {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4.0,
                            child: Text('',style: TextStyle(color: Colors.white)),
                          );
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        // Tu lógica para mostrar los títulos del eje Y
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 4.0,
                          child: Text(value.toString(),style: TextStyle(color: Colors.white)),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                minX: 0,
                maxX: dates.length.toDouble() - 1,
                minY: 0,
                maxY: values.reduce((curr, next) => curr > next ? curr : next) +
                    10,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      dates.length,
                      (index) => FlSpot(index.toDouble(), values[index]),
                    ),
                    isCurved: true,
                    barWidth: 4,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
