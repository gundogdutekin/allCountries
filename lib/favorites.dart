import 'package:flutter/material.dart';
import 'package:ulkeler/customwidget/custom_app_bar.dart';
import 'package:ulkeler/customwidget/custom_build_list_country.dart';
import 'package:ulkeler/models/country_model.dart';

class Favorites extends StatefulWidget {
  final List<Country> _allCountry;

  final List<String> _favoriteCountryCode;

  Favorites(this._allCountry, this._favoriteCountryCode);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Country> _favoritesList = [];
  @override
  void initState() {
    super.initState();
    for (Country country in widget._allCountry) {
      if (widget._favoriteCountryCode.contains(country.countryCode)) {
        _favoritesList.add(country);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: "Favorites",
        height: 55,
        isIcon: true,
      ),
      body: BuildListCountry(
        _favoritesList,
        widget._favoriteCountryCode,
        isHomePage: false,
      ),
    );
  }
}
