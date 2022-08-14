import 'package:dio/dio.dart';

import '../model/weather_response.dart';

class WeatherRepository{
  final Dio _dio = Dio();
  static String mainUrl = "https://api.openweathermap.org/data/2.5";

  Future<WeatherResponse?> fetchWeather() async{
    var weatherUrl = '$mainUrl/forecast?lat=-6.175115064391812&lon=106.82708842419382&appid=253ec4a9c45003c2c71b5caba8655af1&units=metric';
    try{
      Response response = await _dio.get(weatherUrl);
      print('My URL :  $weatherUrl');
      print("data : ${response.data}");
      return WeatherResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print(
          "Exception occured: $error stackTrace: $stacktrace ");
      return null;
    }
  }

}