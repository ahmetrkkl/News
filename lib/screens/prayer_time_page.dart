import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/models/general_prayer_time_result.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
import 'package:news/services/prayer_time_api_service.dart';

import 'exchange_rate_page.dart';
import 'home_screen.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({Key? key}) : super(key: key);

  @override
  PrayerTimePageState createState() => PrayerTimePageState();
}

class PrayerTimePageState extends State<PrayerTimePage> {
  late Future<List<GeneralPrayerTimeResult>> _prayerTimeFuture;

  @override
  void initState() {
    super.initState();
    _prayerTimeFuture = _fetchPrayerTime();
  }

  Future<List<GeneralPrayerTimeResult>> _fetchPrayerTime() async {
    PrayerTimeApiService apiService = PrayerTimeApiService();
    return await apiService.fetchPrayerTime();
  }

  Future<void> _refreshPrayerTime() async {
    setState(() {
      _prayerTimeFuture = _fetchPrayerTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Prayer'.tr()),
      ),
      drawer: Drawer(
        backgroundColor: Colors.red[400],
        child: ListView(
          children: [
            ListTile(
              title: Text('News'.tr()),
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
              title: Text("Pharmacy".tr()),
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
              title: Text('Exchange'.tr()),
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
              title: Text('Weather'.tr()),
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
              title: Text('Prayer'.tr()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'.tr()),
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
        decoration: BoxDecoration(),
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _refreshPrayerTime,
          child: FutureBuilder<List<GeneralPrayerTimeResult>>(
            future: _prayerTimeFuture,
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
                  List<GeneralPrayerTimeResult>? weatherList = snapshot.data;
                  return ListView.builder(
                    itemCount: weatherList!.length,
                    itemBuilder: (context, index) {
                      GeneralPrayerTimeResult prayerTimeItem = weatherList[index];
                      return Card(
                        color: Colors.red.shade900,
                        elevation: 10,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ListTile(
                            title: Text(
                              prayerTimeItem.vakit ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            subtitle: Text(
                              prayerTimeItem.saat ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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