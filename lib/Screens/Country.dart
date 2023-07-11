import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  final Map country;
  Country(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(country['name']['common']),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: const [
              CustomCard(text:'Capital'),
              CustomCard(text:'Population'),
              CustomCard(text:'Show On Map')
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
