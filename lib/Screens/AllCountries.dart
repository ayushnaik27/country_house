import 'package:country_house/Screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Future<List> countries = Future<List>.value([]);
  Future<List> getCountries() async {
    var response = await Dio().get('https://restcountries.com/v3.1/all');
    // print(response.data[1]['name']['common']);
    return response.data;
  }

  @override
  void initState() {
    countries = getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(countries);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('All Countries'),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List>(
            future: countries, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return   ListView.builder( itemBuilder: (BuildContext context, int  i) {
                  return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Country(snapshot.data![i]),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    snapshot.data![i]['name']['common'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
                  
                },
                itemCount: snapshot.data!.length,
                );
           

              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        )
       
        );
  }
}
