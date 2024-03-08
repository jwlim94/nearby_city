import 'dart:convert';

import 'package:nearby_city/nearby_city.dart';
import 'package:http/http.dart' as http;

class RemoteHandler extends NetworkHandler {
  @override
  Future<List<dynamic>> fetchNearbyCity() async {
    final String fileUrl =
        'https://raw.githubusercontent.com/jwlim94/nearby_city_data/main/under_20km_final.json';

    try {
      var response = await http.get(
        Uri.parse(fileUrl),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Unable to fetch nearby city');
      }
    } catch (_) {
      throw Exception('Unable to fetch nearby city');
    }
  }
}
