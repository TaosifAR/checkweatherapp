class WeatherModel{

  final String cityname;
  final double tempreture;
  final String weatherConditon;

 WeatherModel({

    required this.cityname,
   required this.tempreture,
   required this.weatherConditon,

 });

 factory WeatherModel.fromJson(Map<String,dynamic>json) {
return WeatherModel(cityname:json['name'], tempreture: json['main']['temp'], weatherConditon: json['weather'][0]['main']);
 }


}