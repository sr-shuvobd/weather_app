import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CreateWeatherApp extends StatefulWidget {
  const CreateWeatherApp({super.key});

  @override
  State<CreateWeatherApp> createState() => _CreateWeatherAppState();
}

class _CreateWeatherAppState extends State<CreateWeatherApp> {
  String _updated = '';

  String _temperature = '';
  String _tempMin = "";
  String _tempMax = "";
  String _description = '';
  String _iconUrl = '';
  String currentLocation = 'dhaka';
  bool _isLoading = true;
  bool _hasError = false;

  get http => null;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    const apiKey = '5889f50f4b193a66b9d1fd1e68cbab9b';

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$currentLocation&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        setState(() {
          _temperature =
              (weatherData['main']['temp'] - 273.15).toStringAsFixed(1);
          _iconUrl = weatherData['weather'][0]['icon'];
          _tempMin =
              (weatherData['main']['temp_min'] - 273.15).toStringAsFixed(1);
          _tempMax =
              (weatherData['main']['temp_max'] - 273.15).toStringAsFixed(1);
          _description = weatherData['weather'][0]['description'];
          _isLoading = false;

          _updated = DateFormat('hh:mm a').format(DateTime.now());
        });
      } else {
        /**/
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff060720),
      appBar: AppBar(
        title: const Text('Weather App'),
        actions:  [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.add),
              ],
            ),
          )
        ],
      ),
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(70.0),
            child: Column(
              children: [
                Text(
                  'Dhaka',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Updated: $_updated',
                  style: const TextStyle(color: Colors.white54, fontSize: 17),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/w/$_iconUrl.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      _temperature,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'max : $_tempMax',
                          style: TextStyle(color: Colors.white54),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'min : $_tempMin',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),

                Text(
                  "$_description",
                  style: TextStyle(fontSize: 30, color: Colors.white54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateFormat(String s) {}
}