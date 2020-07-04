import 'package:countries/views/AllCountries.dart';
import 'package:countries/views/Country.dart';
import 'package:countries/views/CountryMap.dart';
import 'package:flutter/material.dart';

main() {
  runApp(new MaterialApp(
    home: new AllCountries(),
    routes: {
      Country.routeName: (ctx) => Country(),
      CountryMap.routeName: (ctx) => CountryMap(),
    },
  ));
}
