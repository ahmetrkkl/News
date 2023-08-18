import 'package:easy_localization/easy_localization.dart';
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

  Future<void> _refreshExchangeRate() async {
    setState(() {
      _exchangeRateFuture = _fetchExchangeRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange'.tr(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[900],
        elevation: 0,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerTimePage(),
                  ),
                );
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
          onRefresh: _refreshExchangeRate,
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
                  ExchangeRateResult? exchangeRateResult = snapshot.data;
                  return ListView.builder(
                    itemCount: exchangeRateResult?.data?.length?? 0,
                    itemBuilder: (context, index) {
                      ExchangeRateData? exchangeRateData =
                          exchangeRateResult?.data?[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.red.shade900,
                        child: ListTile(
                          title: Text(exchangeRateData?.name ?? 'Hata',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                          subtitle: Text(exchangeRateData?.code ?? ''),
                          trailing: Text(
                            exchangeRateData?.rate?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
