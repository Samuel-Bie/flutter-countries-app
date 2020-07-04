import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Country.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filteredCountries = [];

  bool isSearching = false;

  getCountries() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  void _filterCountries(String value) {
    setState(() {
      filteredCountries = countries
          .where((element) => element['name']
              .toLowerCase()
              .toString()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = filteredCountries = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text('Countries App')
            : TextField(
                onChanged: (value) => _filterCountries(value),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search countries",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
        actions: <Widget>[
          IconButton(
            icon: this.isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = !this.isSearching;
                if (!this.isSearching)
                  setState(() {
                    filteredCountries = countries;
                  });
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: countries.length > 0
            ? ListCountries(countries: filteredCountries)
            : Loading(),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ],
      ),
    );
  }
}

class ListCountries extends StatelessWidget {
  const ListCountries({
    Key key,
    @required this.countries,
  }) : super(key: key);

  final List countries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Country(countries[index]),
                ),
              );
            },
            child: Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  countries[index]['name'],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        });
  }
}
