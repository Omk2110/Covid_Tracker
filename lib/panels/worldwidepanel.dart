import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  const WorldWidePanel({super.key, required this.worldData});

  final Map worldData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: [
          StatusPanel(
            title: 'Confirmed',
            panelColor: Colors.red[100]!,
            textColor: Colors.red,
            count: worldData["cases"].toString(),
          ),
          StatusPanel(
            title: 'Active',
            panelColor: Colors.blue[100]!,
            textColor: Colors.blue,
            count: worldData["active"].toString(),
          ),
          StatusPanel(
            title: 'Recovered',
            panelColor: Colors.green[100]!,
            textColor: Colors.green,
            count: worldData["recovered"].toString(),
          ),
          StatusPanel(
            title: 'Deaths',
            panelColor: Colors.grey[100]!,
            textColor: Colors.grey,
            count: worldData["deaths"].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  const StatusPanel({
    super.key,
    required this.panelColor,
    required this.textColor,
    required this.title,
    required this.count,
  });

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
