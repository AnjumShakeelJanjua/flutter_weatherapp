import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/weather_model.dart';
import '../data/services/weather_api_service.dart';


part 'weather_provider.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  late final WeatherApiService _weatherApiService;

  @override
  FutureOr<WeatherModel?> build() {
    _weatherApiService = ref.read(weatherApiService);
    return null; // Initial state is null, no weather data fetched yet
  }

  Future<void> fetchWeatherByCity(String city) async {
    state = const AsyncValue.loading();
    try {
      final weather = await _weatherApiService.getCurrentWeatherByCity(city);
      state = AsyncValue.data(weather);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final weatherApiService = Provider((ref) => WeatherApiService());
