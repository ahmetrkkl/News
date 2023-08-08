import 'package:flutter/material.dart';
import 'package:news/models/general_weather_result.dart';
import 'package:news/screens/exchange_rate_page.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/services/weather_api_service.dart';

import 'home_screen.dart';

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
        backgroundColor: Colors.green[900],
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green[200],
        child: ListView(
          children: [
            ListTile(
              title: const Text('Haberler'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Nöbetçi Eczane'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PharmacyPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Döviz Kuru'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExchangeRatePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Hava Durumu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Namaz Vakitleri'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerTimePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent.shade200, Colors.greenAccent.shade100],
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
                      return Card(
                        color: Colors.green[900],
                        elevation: 10,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ListTile(
                            leading: Image.network(
                              weatherItem.icon ?? '',
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                            title: Text(
                              weatherItem.date ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent[200],
                              ),
                            ),
                            subtitle: Text(
                              '${weatherItem.day ?? ''} - ${weatherItem.description ?? ''}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[200],
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Max: ${weatherItem.max ?? '-'}°C',
                                  style: TextStyle(color: Colors.greenAccent[200]),
                                ),
                                Text(
                                  'Min: ${weatherItem.min ?? '-'}°C',
                                  style: TextStyle(color: Colors.greenAccent[200]),
                                ),
                                Text(
                                  'Nem: ${weatherItem.humidity ?? '-'}%',
                                  style: TextStyle(color: Colors.greenAccent[200]),
                                ),
                              ],
                            ),
                          ),
                        ),
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