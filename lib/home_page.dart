import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler/customwidget/custom_build_list_country.dart';
import 'package:ulkeler/favorites.dart';
import 'package:ulkeler/models/country_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";

  ///All country listing
  final List<Country> _allCountry = [];

  List<String> _favoriteCountryCode = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFavoritesList().then((value) => _getAllCountry());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Tüm Ülkeler', style: TextStyle(color: Colors.white)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              _openFavoritesPage(context);
            },
          ),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 113, 153, 223),
    );
  }

  Widget _buildBody() {
    return _allCountry.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : BuildListCountry(
            _allCountry,
            _favoriteCountryCode,
            isHomePage: true,
          );
  }

  void _getAllCountry() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);
    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> countryMap = parsedResponse[i];

      Country country = Country.fromMap(countryMap);
      _allCountry.add(country);
    }
    setState(() {});
  }

  Future<void> _getFavoritesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList("favorites");
    if (favorites != null) {
      for (String favori in favorites) {
        _favoriteCountryCode.add(favori);
      }
    }
  }

  void _openFavoritesPage(BuildContext context) {
    MaterialPageRoute favoritesPage = MaterialPageRoute(
        builder: (context) => Favorites(_allCountry, _favoriteCountryCode));
    Navigator.push(context, favoritesPage);
  }
}
