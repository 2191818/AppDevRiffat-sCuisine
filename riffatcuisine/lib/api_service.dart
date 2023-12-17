import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class ApiService {
  Future<WeatherModel?> getWeather(double latitude, double longitude) async {
    try {
      var url = Uri.parse('https://api.open-meteo.com/weather?latitude=$latitude&longitude=$longitude&hourly=temperature_2m_1h&hourly=precipitation_sum_1h');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        WeatherModel weather = WeatherModel.fromJson(json.decode(response.body));
        return weather;
      }
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }
}
