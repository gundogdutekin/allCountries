class Country {
  String countryCode;
  String name;
  String capital;
  String region;
  String languages;
  int population;
  String flag;

  Country.fromMap(Map<String, dynamic> countryMap)
      : countryCode = countryMap["cca2"] ?? "",
        name = countryMap["name"]?["common"] ?? "",
        capital = (countryMap["capital"] as List<dynamic>).isNotEmpty
            ? countryMap["capital"][0]
            : "",
        region = countryMap["region"] ?? "",
        languages = (countryMap["languages"] as Map<String, dynamic>).isNotEmpty
            ? (countryMap["languages"] as Map<String, dynamic>)
                .entries
                .toList()[0]
                .value
            : "",
        population = countryMap["population"] ?? "",
        flag = countryMap["flags"]?["png"] ?? "";
}
