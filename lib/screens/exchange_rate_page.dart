import 'package:flutter/material.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
import '../models/general_exchange_rate_result.dart';
import '../services/exchange_rate_api_service.dart';
import 'home_screen.dart';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({Key? key}) : super(key: key);

  @override
  ExchangeRatePageState createState() => ExchangeRatePageState();
}

class ExchangeRatePageState extends State<ExchangeRatePage> {
  late Future<List<GeneralExchangeRateResult>> _exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    _exchangeRateFuture = _fetchExchangeRate();
  }

  Future<List<GeneralExchangeRateResult>> _fetchExchangeRate() async {
    ExchangeRateApiService apiService = ExchangeRateApiService();
    return await apiService.fetchExchangeRate();
  }
  Future<void> _refreshExchangeRate() async {
    setState(() {
      _exchangeRateFuture = _fetchExchangeRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Döviz Kuru'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
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
      body: RefreshIndicator(
        onRefresh: _refreshExchangeRate,
        child: FutureBuilder<List<GeneralExchangeRateResult>>(
          future: _exchangeRateFuture,
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
                List<GeneralExchangeRateResult>? exchangeRateList = snapshot.data;
                return ListView.builder(
                  itemCount: exchangeRateList!.length,
                  itemBuilder: (context, index) {
                    GeneralExchangeRateResult exchangeRateItem = exchangeRateList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          '${exchangeRateItem.name ?? ''} ',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exchangeRateItem.code ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              exchangeRateItem.calculatedstr ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
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