import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherApiService {
  final Dio _dio = Dio();
  final String _apiKey =
      '9a2aa1e3ca9ed42801b63cb93d0f6483'; // Replace with your OpenWeatherMap API key
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getCurrentWeatherByCity(String city) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'units': 'metric', // or 'imperial'
        },
      );
      return WeatherModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to get weather by city: $error');
    }
  }

  Future<WeatherModel> getCurrentWeatherByLocation(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric', // or 'imperial'
        },
      );
      return WeatherModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to get weather by location: $error');
    }
  }
}
