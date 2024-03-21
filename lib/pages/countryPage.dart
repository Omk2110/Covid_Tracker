import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:tgd_covid_tracker/datasorce.dart';
import 'package:tgd_covid_tracker/pages/search.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List? countryData;

  fetchCountryData() async {
    var url = Uri.https('disease.sh', '/v3/covid-19/countries');
    var response = await http.get(url);
    setState(() {
      countryData = convert.jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlack,
        title: Text('Country Stats'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(countryData!));
            },
            icon: Icon(Icons.search),
            splashRadius: 30,
          ),
        ],
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: (Theme.of(context).brightness == Brightness.dark)
                      ? BoxDecoration(
                          color: Colors.blueGrey[900],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[900]!,
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        )
                      : BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[100]!,
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countryData![index]['country'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countryData![index]['countryInfo']['flag'],
                              height: 60,
                              width: 70,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFIRMED ' +
                                    countryData![index]['cases'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'ACTIVE ' +
                                    countryData![index]['active'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'RECOVERED ' +
                                    countryData![index]['recovered'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'DEATHS ' +
                                    countryData![index]['deaths'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                      ? Colors.grey[400]
                                      : Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData!.length,
            ),
    );
  }
}
