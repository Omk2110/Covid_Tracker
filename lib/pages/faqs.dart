import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasorce.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ\'s'),
        backgroundColor: primaryBlack,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              DataSource.questionAnswers[index]['question'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  DataSource.questionAnswers[index]['answer'],
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          );
        },
        itemCount: DataSource.questionAnswers.length,
      ),
    );
  }
}
