import 'package:country_house/Screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllCountries extends StatefulWidget {
  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  bool _isSearching = false;
  List countries = [];
  List filteredCountries = [];

  // void gello() async {
  //   await Dio().get(
  //     'https://restcountries.com/v3.1/all',
  //     options: Options(

  //     )
  //   );
  // }

  getCountries() async {
    var response = await Dio().get('https://restcountries.com/v3.1/all');
    // print(response.data[18]);
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

  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    // print(countries);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                _isSearching
                    ? Expanded(
                        child: TextField(
                          onChanged: (value) {
                            _filterCountries(value);
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              fillColor: Color.fromRGBO(195, 172, 208, 1),
                              filled: true,
                              hintText: 'Search Countries Here',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      )
                    : const Expanded(
                        child: Text(
                          'All Countries',
                          style: TextStyle(
                              fontFamily: 'Sansita',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                      ),
                _isSearching
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                            filteredCountries = countries;
                          });
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isFirst = false;
                            _isSearching = true;
                          });
                        },
                        icon: const Icon(Icons.search))
              ],
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: filteredCountries.isNotEmpty
                      ? ListView.builder(
                          // gridDelegate:
                          //     const SliverGridDelegateWithMaxCrossAxisExtent(
                          //         maxCrossAxisExtent: 200,
                          //         childAspectRatio: 0.8,
                          //         crossAxisSpacing: 5,
                          //         mainAxisSpacing: 5),
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
                              child:
                                  // CountryGridTile(country: filteredCountries[i]),
                                  CountryTile(country: filteredCountries[i]),
                            );
                          },
                          itemCount: filteredCountries.length,
                        )
                      : Center(
                          child: _isFirst
                              ? const CircularProgressIndicator()
                              : const Text('No such country'),
                        )),
            ),
          ],
        ));
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Card(
            elevation: 0,
            color: Color.fromRGBO(119, 67, 219, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
          ),
          Positioned(
            bottom: 20,
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
                      fontSize: 20, color: Color.fromRGBO(255, 251, 245, 1)),
                ),
                Text(
                  'Capital: ${country['capital'] == null ? 'N/A' : country['capital'][0]}',
                  style:
                      const TextStyle(color: Color.fromRGBO(247, 239, 229, 1)),
                ),
                Text(
                  'Population: ${NumberFormat('#,##,###').format(country['population'])}',
                  style:
                      const TextStyle(color: Color.fromRGBO(247, 239, 229, 1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CountryGridTile extends StatelessWidget {
  final Map country;
  const CountryGridTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.network(
                country['flags']['png'],
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              country['name']['common'],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ));
  }
}
