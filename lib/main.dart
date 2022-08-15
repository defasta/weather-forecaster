import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecaster/bloc/weather_bloc.dart';
import 'package:weather_forecaster/bloc/weather_event.dart';
import 'package:weather_forecaster/repositories/weather_repository.dart';
import 'package:weather_forecaster/ui/weather_detail.dart';
import 'bloc/weather_state.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const WeatherForecastApp());
}

class WeatherForecastApp extends StatefulWidget {
  const WeatherForecastApp({Key? key}):super(key: key);


  @override
  State<WeatherForecastApp> createState() => _WeatherForecastAppState();
}

class _WeatherForecastAppState extends State<WeatherForecastApp> {
  WeatherBloc _weatherBloc = WeatherBloc(weatherRepository: WeatherRepository());
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    _weatherBloc.add(FetchWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('Weather App'),
            ),
            body:Container(
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BlocProvider(
                          create:(_) => _weatherBloc,
                          child: BlocListener<WeatherBloc, WeatherState>(
                            listener: (context, state){},
                            child: BlocBuilder<WeatherBloc, WeatherState>(
                                builder: (context, state){
                                  if(state is WeatherInitial){
                                    return Container();
                                  }else if(state is WeatherLoading){
                                    child: Center(child: CircularProgressIndicator());
                                  }else if(state is WeatherLoaded){
                                    return Expanded(
                                      child: Container(
                                        //padding: EdgeInsets.all(15),
                                        child: ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              DateTime formattedDate = dateFormat.parse(state.weather?.data?[index].date! ?? '');
                                              var date = DateFormat.yMMMMEEEEd().add_jm().format(formattedDate);
                                              return  InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WeatherDetail(date: date, temp: state.weather?.data?[index].main?.temp.toString(), temp_max: state.weather?.data?[index].main?.tempMax.toString(), temp_min: state.weather?.data?[index].main?.tempMin.toString(), condition: state.weather?.data?[index].weatherData?[0].main.toString(), detail_condition: state.weather?.data?[index].weatherData?[0].description, img_url: state.weather?.data?[index].weatherData?[0].icon),),);
                                                  });
                                                },
                                                child:  Container(
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.4),
                                                      //borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(color: Colors.black26, width: 0.2)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: 2),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Image.network('http://openweathermap.org/img/wn/${state.weather?.data?[index].weatherData?[0].icon}.png', height: 50, width: 50,),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 15),
                                                                  child: Text(
                                                                    date ?? '',
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.black),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 15),
                                                                  child: Text(
                                                                    state.weather?.data?[index].weatherData?[0].main ?? '',
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black54),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 15),
                                                                  child: Text(
                                                                    'Temp: ${state.weather?.data?[index].main?.temp.toString()}°C'?? '',
                                                                    style: TextStyle(
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black54),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) => SizedBox(height: 1),
                                            itemCount: state.weather?.data?.length ?? 0),
                                      ),
                                    );
                                  }else if (state is WeatherFailure) {
                                    return Container(
                                      child: Center(
                                        child: Text('Gagal menampilkan data'),
                                      ),
                                    );
                                  }
                                  return Container();
                                }
                            ),
                          )
                      )
                    ]))
        ),
      )

    );

  }
}
