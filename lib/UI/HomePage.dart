import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



 


  static String API_KEY = 'eec41461f7644240bd5174131243103'; //Paste Your API Here

  String location = 'Bahir dar'; //Default location
  String weatherIcon = 'heavycloud.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';

  //API Call
  String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=$API_KEY&days=7&q=";

  void fetchWeatherData(String search) async{
    
    try{

      print('reached here');
      var res=await http.get(Uri.parse(searchWeatherAPI+search));


      final weatherData=Map<String, dynamic>.from(
        json.decode(res.body)??'no data'
      );

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location=getShortLocationName(locationData["name"]);
        print(location);
      });
      
        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;
    }
    catch(e){

    }


  

  }

static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");
    print('here too');

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        
        print(wordList);
        return wordList[0];
      }
    } else {
      return " ";
    }
  }



@override
  void initState(){
    getShortLocationName(location);
    print('here');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'currentDate',
            style: TextStyle(
              color: Colors.white
            ),
            
          ),
        ),

      ),
    );
  }
}