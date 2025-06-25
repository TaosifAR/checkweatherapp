import 'dart:convert';
import 'dart:developer';

import 'package:checkweather/models/weather_model.dart';
import 'package:checkweather/pages/weather_page.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
class WeatherService{

  static const URL = 'https://api.openweathermap.org/data/2.5/weather';


final String apikey;
WeatherService(this.apikey);

Future<WeatherModel>getWeather(String cityName) async{

  final response = await http.get(Uri.parse('$URL?q=$cityName&appid=$apikey&units=metric'));
  log(response.body);
  if(response.statusCode == 200)
    {
      return WeatherModel.fromJson(jsonDecode(response.body));

    }
  else
    {
      throw Exception('Failed to load weather data');
    }
}
Future<String> getCurrentCity() async{
  LocationPermission permisson = await Geolocator.checkPermission();
  if(permisson == LocationPermission.denied)
    {
      permisson = await Geolocator.requestPermission();
    }
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
  String? cityName = placemarks[0].locality?.trim();

  if (cityName == "Chattogram") cityName = "Chittagong";
  print("City from geolocation: $cityName");

  return cityName?? "";

}



}