import 'dart:convert';

class WeatherResponse{
  String? cod;
  int? message;
  int? cnt;
  List<Data>? data;

  WeatherResponse({this.cod, this.message, this.cnt,this.data});

  WeatherResponse.fromJson(Map<String, dynamic> json){
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      data = <Data>[];
      json['list'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
    if (this.data != null) {
      data['list'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data{
  Main? main;
  List<WeatherData>? weatherData;
  String? date;

  Data({this.main, this.weatherData, this.date});

  Data.fromJson(Map<String, dynamic> json){
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weatherData= <WeatherData>[];
      json['weather'].forEach((v) {
        weatherData!.add(new WeatherData.fromJson(v));
      });
      date = json['dt_txt'];
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    };
    if (this.weatherData != null) {
      data['weather'] = this.weatherData!.map((v) => v.toJson()).toList();
    }
    data['dt_txt'] = this.date;
    return data;
  }
}

class Main{
  double? temp;
  double? tempMin;
  double? tempMax;

  Main({this.temp, this.tempMin, this.tempMax});

  Main.fromJson(Map<String, dynamic> json){
    temp = json['temp'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    return data;
  }
}

class WeatherData{
  String? main;
  String? description;
  String? icon;

  WeatherData({this.main, this.description, this.icon});

  WeatherData.fromJson(Map<String, dynamic> json){
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

