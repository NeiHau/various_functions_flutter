import 'package:dio/dio.dart';

class CountryService {
  final Dio _dio = Dio();

  Future<List<String>> getCountries() async {
    try {
      Response response = await _dio.get('https://restcountries.com/v3.1/all');
      if (response.statusCode == 200) {
        List<String> countries = (response.data as List)
            .map((country) => country['name']['common'] as String)
            .toList();
        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
