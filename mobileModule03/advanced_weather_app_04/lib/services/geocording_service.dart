import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  static Future<List<dynamic>> searchCity(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search?name=$query&count=10&language=en&format=json"
    );

    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"] ?? [];
    } else {
      return [];
    }
  }
}
