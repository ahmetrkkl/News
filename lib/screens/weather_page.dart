import 'package:flutter/material.dart';
import '../models/general_weather_result.dart';
import '../services/weather_api_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  late Future<List<GeneralWeatherResult>> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _fetchWeather();
  }

  Future<List<GeneralWeatherResult>> _fetchWeather() async {
    WeatherApiService apiService = WeatherApiService();
    return await apiService.fetchWeather();
  }
  Future<void> _refreshWeather() async {
    setState(() {
      _weatherFuture = _fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeather,
        child: FutureBuilder<List<GeneralWeatherResult>>(
          future: _weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.hasData) {
                List<GeneralWeatherResult>? weatherList = snapshot.data;
                return ListView.builder(
                  itemCount: weatherList!.length,
                  itemBuilder: (context, index) {
                    GeneralWeatherResult weatherItem = weatherList[index];
                    return ListTile(
                      title: Text(weatherItem.date ?? ''),
                      subtitle: Text(weatherItem.day ?? ''),
                      trailing: Text(weatherItem.description ?? ''),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data available.'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}