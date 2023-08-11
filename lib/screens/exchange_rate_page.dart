import 'package:flutter/material.dart';
import 'package:news/models/general_exchange_rate_result.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
import 'package:news/services/exchange_rate_api_service.dart';

import 'home_screen.dart';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({Key? key}) : super(key: key);

  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  late Future<ExchangeRateResult?> _exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    _exchangeRateFuture = _fetchExchangeRate();
  }

  Future<ExchangeRateResult?> _fetchExchangeRate() async {
    ExchangeRateApiService apiService = ExchangeRateApiService();
    return await apiService.fetchExchangeRate();
  }

  Future<void> _refreshWeather() async {
    setState(() {
      _exchangeRateFuture = _fetchExchangeRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Döviz Kuru', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[200],
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
              },
            ),
            ListTile(
              title: const Text('Hava Durumu'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherPage(),
                  ),
                );
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
            colors: [Colors.blueAccent.shade200, Colors.blueAccent.shade100],
          ),
        ),
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _refreshWeather,
          child: FutureBuilder<ExchangeRateResult?>(
            future: _exchangeRateFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Hata: ${snapshot.error}'),
                );
              } else {
                if (snapshot.hasData) {
                  ExchangeRateResult? exchangeRateList = snapshot.data;
                  return ListView.builder(
                    itemCount: exchangeRateList!.data?.length,
                    itemBuilder: (context, index) {
                      List<ExchangeRateData>? exchangeRateData =
                          exchangeRateList.data;
                      return ListTile(
                        title: Text(exchangeRateList.lastupdate ?? 'Hata'),
                        textColor: Colors.amber,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Veri yok.',
                      style: TextStyle(color: Colors.amber),
                    ),
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
