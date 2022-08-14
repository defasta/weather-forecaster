import 'package:equatable/equatable.dart';
import 'package:weather_forecaster/model/weather_response.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState{
  const WeatherInitial();
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState{
  const WeatherLoading();
  List<Object> get props => [];
}

class WeatherFailure extends WeatherState{
  final String error;
  const WeatherFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Weather failure { error : $error}';
}

class WeatherLoaded extends WeatherState{
  final WeatherResponse? weather;

  const WeatherLoaded({required this.weather});
  @override
  String toString() => 'Weather Loaded {data: $weather}';
  @override
  List<Object> get props => [weather!];
}