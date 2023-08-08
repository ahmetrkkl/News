import 'package:flutter/material.dart';
import 'package:news/models/general_weather_result.dart';
import 'package:news/services/weather_api_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
        title: Text('Hava Durumu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade100],
          ),
        ),
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _refreshWeather,
          child: FutureBuilder<List<GeneralWeatherResult>>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Hata: ${snapshot.error}'),
                );
              } else {
                if (snapshot.hasData) {
                  List<GeneralWeatherResult>? weatherList = snapshot.data;
                  return ListView.builder(
                    itemCount: weatherList!.length,
                    itemBuilder: (context, index) {
                      GeneralWeatherResult weatherItem = weatherList[index];
                      return ListTile(
                        tileColor: Colors.black,
                        leading: Image.network(
                          weatherItem.icon ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          weatherItem.date ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          '${weatherItem.day ?? ''} - ${weatherItem.description ?? ''}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Max: ${weatherItem.max ?? '-'}°C',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Min: ${weatherItem.min ?? '-'}°C',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Nem: ${weatherItem.humidity ?? '-'}%',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        // Hava durumu bilgilerini buraya ekleyin.
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Veri yok.'),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
