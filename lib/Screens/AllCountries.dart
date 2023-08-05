import 'package:country_house/Screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  bool _isSearching = false;
  List countries = [];
  List filteredCountries = [];

  getCountries() async {
    var response = await Dio().get('https://restcountries.com/v3.1/all');
    // print(response.data[1]['name']['common']);
    return response.data;
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

  void _filterCountries(String val) {
    print(val);
    setState(() {
      // filteredCountries = countries
      //     .where((country) => country['name']['common'] == val)
      //     .toList();
      filteredCountries = countries
          .where((element) => element['name']['common']
              .toString()
              .toLowerCase()
              .startsWith(val.toLowerCase()))
          .toList();
    });
  }

  bool _isFirst= true;

  @override
  Widget build(BuildContext context) {
    // print(countries);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: _isSearching
              ? TextField(
                  onChanged: (value) {
                    _filterCountries(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: 'Search Countries Here',
                      hintStyle: TextStyle(color: Colors.white)),
                )
              : const Text('All Countries'),
          actions: [
            _isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        filteredCountries = countries;
                      });
                    },
                    icon: const Icon(Icons.cancel_outlined))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isFirst=false;
                        _isSearching = true;
                      });
                    },
                    icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(5),
            child: filteredCountries.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Country(filteredCountries[i]),
                            ),
                          );
                        },
                        child: CountryTile(country: filteredCountries[i]),
                      );
                    },
                    itemCount: filteredCountries.length,
                  )
                :  Center(
                    child: _isFirst ? const CircularProgressIndicator() : const Text('No such country'),
                  )));
  }
}


class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.country,
  });

  final Map country;

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Stack(fit: StackFit.expand, children: [
        const Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 15,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(country['flags']['png']),
          ),
        ),
        Positioned(
          left: 90,
          top: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                country['name']['common'],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Capital: ${country['capital']}',
                style: TextStyle(color: Colors.grey.shade400),
                
              ),
              Text(
                'Population: ${country['population']}',
                style: TextStyle(color: Colors.grey.shade400),
                
              ),
              
            ],
          ),
        ),
      ]),
    );
  }
}
