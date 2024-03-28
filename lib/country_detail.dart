import 'package:flutter/material.dart';
import 'package:ulkeler/customwidget/custom_app_bar.dart';
import 'package:ulkeler/models/country_model.dart';

class CountryDetail extends StatelessWidget {
  final Country _country;
  const CountryDetail(this._country, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: _country.name,
        height: 55,
        isIcon: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Column(children: [
      const SizedBox(
        width: double.infinity,
        height: 25,
      ),
      _buildFlag(context),
      const SizedBox(
        height: 10,
      ),
      _buildCountryTitleText(),
      _buildDetailColumn()
    ]);
  }

  Widget _buildDetailColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: Column(
        children: [
          _buildDetailRow("Ülke İsmi", _country.name),
          _buildDetailRow("Başkenti", _country.capital),
          _buildDetailRow("Kodu", _country.countryCode),
          _buildDetailRow("Kıta", _country.region),
          _buildDetailRow("Lisan", _country.languages),
          _buildDetailRow("Nüfus", _country.population.toString()),
        ],
      ),
    );
  }

  Widget _buildFlag(BuildContext context) {
    return Image.network(
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
      _country.flag,
    );
  }

  Widget _buildCountryTitleText() {
    return Text(_country.name,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _buildDetailRow(String columnName, String fieldValue) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$columnName :",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            fieldValue,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
