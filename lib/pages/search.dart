import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasorce.dart';

class Search extends SearchDelegate {
  Search(this.countryList);

  final List countryList;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear_rounded),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) => element['country']
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
    return searchList(suggestionList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) => element['country']
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();

    return searchList(suggestionList);
  }

  ListView searchList(List<dynamic> suggestionList) {
    return ListView.builder(
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
                      suggestionList![index]['country'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Image.network(
                      suggestionList![index]['countryInfo']['flag'],
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
                            suggestionList![index]['cases'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'ACTIVE ' + suggestionList![index]['active'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'RECOVERED ' +
                            suggestionList![index]['recovered'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'DEATHS ' + suggestionList![index]['deaths'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              (Theme.of(context).brightness == Brightness.dark)
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
      itemCount: suggestionList.length,
    );
  }
}
