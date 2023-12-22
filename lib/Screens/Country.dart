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
          backgroundColor: const Color.fromRGBO(119, 67, 219, 1),
          title: Text(
            country['name']['common'],
            style: const TextStyle(
                fontFamily: 'Sansita',
                fontStyle: FontStyle.italic,
                fontSize: 30),
          ),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   country['name']['common'],
              //   style: const TextStyle(fontSize: 30),
              // ),
              const SizedBox(height: 10),
              const Text('Flag: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Image(
                image: NetworkImage(country['flags']['png']),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(119, 67, 219, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    RichRow(
                        boldText: 'Official Name: ', valueText: _officialName),
                    RichRow(boldText: 'Capital: ', valueText: _capital),
                    RichRow(boldText: 'Population: ', valueText: _population),
                    RichRow(
                        boldText: 'Area: ',
                        valueText: '$_area square kilometers'),
                    RichRow(boldText: 'Timezone: ', valueText: _timezone),
                  ],
                ),
              ),

              const Expanded(child: SizedBox(height: 10)),
              ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(195, 172, 208, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Show on Map'),
              ),
            ],
          ),
        ));
  }
}
