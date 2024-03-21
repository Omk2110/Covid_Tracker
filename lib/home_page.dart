import 'dart:convert' as convert;

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'package:tgd_covid_tracker/datasorce.dart';
import 'package:tgd_covid_tracker/pages/countryPage.dart';
import 'package:tgd_covid_tracker/panels/infopanel.dart';
import 'package:tgd_covid_tracker/panels/mostaffectedcountries.dart';
import 'package:tgd_covid_tracker/panels/worldwidepanel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? worldData;

  fetchWorldWideData() async {
    var url = Uri.https('disease.sh', '/v3/covid-19/all');
    var response = await http.get(url);
    setState(() {
      worldData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    });
  }

  List? countryData;

  fetchCountryData() async {
    var url = Uri.parse('https://disease.sh/v3/covid-19/countries?sort=cases');
    var response = await http.get(url);
    setState(() {
      countryData = convert.jsonDecode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                EasyDynamicTheme.of(context).changeTheme();
              },
              splashRadius: 20,
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded))
        ],
        backgroundColor: primaryBlack,
        centerTitle: false,
        title: const Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(18),
                height: 100,
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cirular',
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WorldWide',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CountryPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Regional',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Circular',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? const CircularProgressIndicator()
                  : WorldWidePanel(
                      worldData: worldData!,
                    ),
              worldData == null
                  ? Container()
                  : PieChart(
                      dataMap: {
                        "Confirmed": worldData!['cases'].toDouble(),
                        "Active": worldData!['active'].toDouble(),
                        "Recovered": worldData!['recovered'].toDouble(),
                        "Deaths": worldData!['deaths'].toDouble(),
                      },
                      animationDuration: Duration(milliseconds: 800),
                      colorList: [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.blueGrey
                            : Colors.grey
                      ],
                      chartValuesOptions:
                          ChartValuesOptions(showChartValuesInPercentage: true),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Circular',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(CountryData: countryData!),
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'We are together in the fight',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
