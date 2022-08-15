import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  String? date, temp, temp_max, temp_min, condition, detail_condition, img_url;
  WeatherDetail({Key? key,required this.date,required this.temp,required this.temp_max, required this.temp_min, required this.condition, required this.detail_condition, required this.img_url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Weather Details'),
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(date!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' $temp°C', style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  Image.network('http://openweathermap.org/img/wn/${img_url}@2x.png', height: 100, width: 100,),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('${condition} (${detail_condition})', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),),
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Temp (min)', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),),
                        Text('$temp_min°C', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Temp (max)', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),),
                        Text('$temp_max°C', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
                      ],
                    )
                  ],
              )
            ],
          ),
        ),
      ),
    );
  }
}