import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() =>
  runApp( MaterialApp(
 home: Weather(),

  ));

class Weather  extends StatefulWidget {


  @override
  State<StatefulWidget> createState (){
    return _WeatherState();
}
}




class _WeatherState  extends State<Weather> {
var temp;
var description;
var currently;
var humidity;
var windSpeed;

  Future getWeather () async {
   http.Response response = await  http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Paris&units=imperial&appid=a2d27e8c9f07077bf5f215cb90715c2c"));
   var results = jsonDecode(response.body);
setState(() {
  this.temp = results['main']['temp'];
  this.description = results['weather'][0]['description'];
  this.currently = results['weather'][0]['main'];
  this.humidity = results['main']['humidity'];
  this.windSpeed = results['wind']['speed'];

});


}

@override
void initState(){
super.initState();
this.getWeather();


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Column(
    children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width,
        color: Colors.lightBlueAccent,
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0,0.0),
                  child: Text(
                   'Paris',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.red

                  )

                  ),
              ),

               Text(
                 temp != null ? temp.toString() + "\u00B0" : "loading",
                 style: TextStyle(
                   fontSize: 40,
                   fontWeight: FontWeight.bold,
                   color: Colors.red,

                 ),

               ),
              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0,0.0),

              child :Text(
    currently != null ? currently.toString() + "\u00B0" : "loading",
                  style:TextStyle(
                    color:Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,


                  ),

                ),


              ),


              ]

        ),



      ),
      Expanded(
        child:Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[

              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text('Tempretature'),
                trailing: Text(temp != null ? temp.toString() + "\u00B0" : "loading"),

              ),


              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text('Weather'),
                trailing: Text(description != null ? description.toString()  : "loading"),

              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text('Humidity'),
                trailing: Text(humidity != null ? humidity.toString()  : "loading"),

              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text('wind speed'),
                trailing: Text(windSpeed != null ? windSpeed.toString()  : "loading"),

              ),
            ],



          ),

        ),



      ),

    ],


  ),


    );
  }
}
