class WeatherModel {
  final List<double> temperature;
  final List<double> precipitation;

  WeatherModel({
    required this.temperature,
    required this.precipitation,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: List<double>.from(json['hourly']['temperature_2m_1h']),
      precipitation: List<double>.from(json['hourly']['precipitation_sum_1h']),
    );
  }
}
