import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Country extends StatelessWidget {
  final Map country;

  Country(this.country);

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(country['maps']['googleMaps']);
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
              const Text('Flag: '),
              const SizedBox(height: 5),
              Image(
                image: NetworkImage(country['flags']['png']),
              ),
              const SizedBox(height: 10),
              Text('Official Name: ${country['name']['official']}'),
              Text(country['maps']['openStreetMaps']),


              ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(url,mode: LaunchMode.inAppWebView)) {
                    throw Exception(
                        'Could not launch $url');
                  }
                },
                child: Text('Show on Map'),
              ),

              
            ],
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  final String text;
  const CustomCard({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Center(child: Text(text)),
    );
  }
}
