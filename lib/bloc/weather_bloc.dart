import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecaster/bloc/weather_event.dart';
import 'package:weather_forecaster/bloc/weather_state.dart';
import 'package:weather_forecaster/repositories/weather_repository.dart';

import '../model/weather_response.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository _weatherRepository = WeatherRepository();
  WeatherResponse? _weatherResponse;

  WeatherBloc({required WeatherRepository weatherRepository}): super(WeatherInitial()){
    weatherRepository = WeatherRepository();
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async{
    try{
      emit(const WeatherLoading());
      _weatherResponse = await _weatherRepository.fetchWeather();
      emit(WeatherLoaded(weather: _weatherResponse));
    }catch(e){
      emit(const WeatherFailure(error: "error"));
    }
  }
}