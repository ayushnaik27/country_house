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
          .where(
              (element) => element['name']['common'].toString().startsWith(val))
          .toList();
    });
  }

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
                        _isSearching = true;
                      });
                    },
                    icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(5),
            child: filteredCountries.length > 0
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
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: Text(
                              filteredCountries[i]['name']['common'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: filteredCountries.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
