import 'dart:convert';

import 'package:move_application/constant/strings.dart';
import 'package:http/http.dart' as http;

import '../model/popular_model.dart';

class PopularMoviesWebServices {

  Future<List<Results>?> fetchMovies() async {
    const url = "$baseUrl/popular?language=en-US&page=1";

    final headers = {
      "accept": "application/json",
      "Authorization":
      "Bearer $authorizationKey",
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movieList = Popular.fromJson(jsonData).results;
      print(response.body);
      return movieList;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}