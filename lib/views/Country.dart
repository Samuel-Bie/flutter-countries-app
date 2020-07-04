import 'package:countries/views/CountryMap.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Country extends StatelessWidget {

  static const routeName = '/country';

  // final Map country;
  // Country(this.country);

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            /* capital Flip card */
            FlipCard(
              front: CountryCard(title: 'Capital'),
              back: CountryBackCard(
                title: country['capital'],
                color: Colors.deepPurple,
              ),
              direction: FlipDirection.VERTICAL,
            ),

            /* Population Flip card */
            FlipCard(
              front: CountryCard(title: 'Population'),
              back: CountryBackCard(
                title: country['population'].toString(),
                color: Colors.blue,
              ),
              direction: FlipDirection.VERTICAL,
            ),
            /* Flag Flip card */
            FlipCard(
              front: CountryCard(title: 'Flag'),
              back: ImageBackcard(url: country['flag']),
              direction: FlipDirection.VERTICAL,
            ),
            /* Currency Flip card */
            FlipCard(
              front: CountryCard(title: 'Currency'),
              back: CountryBackCard(
                title: country['currencies'][0]['name'],
                color: Colors.deepOrange,
              ),
              direction: FlipDirection.VERTICAL,
            ),
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(
                  context,
                  CountryMap.routeName,
                  arguments: country,
                )
              },
              child: CountryCard(title: 'Show on Map'),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryBackCard extends StatelessWidget {
  final String title;
  final MaterialColor color;
  const CountryBackCard({
    Key key,
    @required this.title,
    this.color = Colors.deepOrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  const CountryCard({
    Key key,
    @required this.title,
    this.country,
  }) : super(key: key);

  final Map country;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ImageBackcard extends StatelessWidget {
  final String url;
  const ImageBackcard({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: SvgPicture.network(
        url,
        placeholderBuilder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator()),
      ),
    );
  }
}
