import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler/country_detail.dart';
import 'package:ulkeler/models/country_model.dart';

// ignore: must_be_immutable
class BuildListCountry extends StatefulWidget {
  List<Country> _allCountry = [];

  List<String> _favoriteCountryCode = [];

  bool isHomePage;

  BuildListCountry(this._allCountry, this._favoriteCountryCode,
      {this.isHomePage = true, super.key});

  @override
  State<BuildListCountry> createState() => _BuildListCountryState();
}

class _BuildListCountryState extends State<BuildListCountry> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._allCountry.length, itemBuilder: _buildListItem);
  }

  Widget _buildListItem(BuildContext context, int index) {
    Country country = widget._allCountry[index];
    return Card(
      child: ListTile(
        title: Text(country.name),
        subtitle: Text("Başkent:${country.capital}"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(country.flag),
        ),
        trailing: IconButton(
          onPressed: () => _favoriteAddToCountryList(country),
          icon: Icon(
            widget.isHomePage == true
                ? widget._favoriteCountryCode.contains(country.countryCode)
                    ? Icons.favorite
                    : Icons.favorite_border
                : null,
            color: Colors.red,
          ),
        ),
        onTap: () {
          _onClickCountryDetail(context, country);
        },
      ),
    );
  }

  void _onClickCountryDetail(BuildContext context, Country country) {
    MaterialPageRoute path =
        MaterialPageRoute(builder: (context) => CountryDetail(country));
    Navigator.push(context, path);
  }

  void _favoriteAddToCountryList(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget._favoriteCountryCode.contains(country.countryCode)) {
      widget._favoriteCountryCode.remove(country.countryCode);
    } else {
      widget._favoriteCountryCode.add(country.countryCode);
    }
    await prefs.setStringList("favorites", widget._favoriteCountryCode);

    setState(() {});
  }
}
