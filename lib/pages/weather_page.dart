import 'dart:developer';

import 'package:checkweather/models/weather_model.dart';
import 'package:checkweather/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherapi= WeatherService('6c57f3225feb55c6c56bc044323f6b98');
  WeatherModel? _weatherModel;

 _fetchWeather() async{
   final cityName = await _weatherapi.getCurrentCity();
   print("wpage cityname: ${cityName.toString()}");
   try {
     final weatherModel = await _weatherapi.getWeather(cityName);
     print("hehewpage cityname: ${weatherModel.cityname.toString()}");


     setState(() {
       _weatherModel = weatherModel;
       print(_weatherModel?.cityname);
     });
   }
   catch(e)
   {
     print(e);
   }


 }




  String getweatheranimation(String? WeatherCondition)
  {
    if(WeatherCondition == null) return 'assets/Sunny.json';
    switch(WeatherCondition.toLowerCase())
    {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/Cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rainy.json';
      case 'thunderstorm':
        return 'assets/Thunder.json';
      case 'clear':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
    }



  }
  @override
  void initState() {


    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
   print(_weatherModel?.cityname.toString());
   var msize = MediaQuery.of(context).size;
    return Scaffold(


      body: Center(
          child:





              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,color: Colors.green,),
                  Text(_weatherModel?.cityname?? "Loading city name",style: TextStyle(fontSize: msize.width * .055,fontWeight: FontWeight.bold,color: Colors.black54),),
                  Lottie.asset(getweatheranimation(_weatherModel?.weatherConditon,),height: msize.width * .5,width: msize.width * .5,fit: BoxFit.fill),

                  Text('${_weatherModel?.tempreture.round().toString()}°C',style: TextStyle(fontSize: msize.width * .055,fontWeight: FontWeight.bold,color: Colors.black54),),
                  Text("${_weatherModel?.weatherConditon}",style: TextStyle(fontSize: msize.width * .055,fontWeight: FontWeight.bold,color: Colors.black54),),
                ],
              ),





        ),


    );
  }
}
