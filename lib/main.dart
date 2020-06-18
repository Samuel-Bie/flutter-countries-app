import 'package:flutter/material.dart';

main() {
  runApp(new MaterialApp(
    home: AllCountries(),
  ));
}

class AllCountries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries App'),
      ),
    );
  }
}
