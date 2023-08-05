import 'package:country_house/widgets/DefaultRichText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Country extends StatelessWidget {
  final Map country;

  Country(this.country);

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(country['maps']['googleMaps']);
    final String _capital = country['capital'][0];
    final String _timezone = country['timezones'][0];
    final String _population =
        NumberFormat('#,##,###').format(country['population']);
    final String _area = NumberFormat('#,##,###').format(country['area']);
    final String _officialName = country['name']['official'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(country['name']['common']),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                country['name']['common'],
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10),
              const Text('Flag: ',style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Image(
                image: NetworkImage(country['flags']['png']),
              ),
              const SizedBox(height: 10),
              
              
              DefaultRichText(boldText: 'Official Name: ',valueText: _officialName),
              DefaultRichText(boldText: 'Capital: ',valueText: _capital),
              DefaultRichText(boldText: 'Population: ',valueText: _population),
              DefaultRichText(boldText: 'Area: ',valueText: '$_area square kilometers'),
              DefaultRichText(boldText: 'Timezone: ',valueText: _timezone),
              ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Text('Show on Map'),
              ),
            ],
          ),
        ));
  }
}


