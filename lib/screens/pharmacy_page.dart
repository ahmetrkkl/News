  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
  import 'package:news/services/pharmacy_api_service.dart';
  import '../models/general_pharmacy_result.dart';
import 'exchange_rate_page.dart';

  class PharmacyPage extends StatefulWidget {
    const PharmacyPage({Key? key}) : super(key: key);

    @override
    PharmacyPageState createState() => PharmacyPageState();
  }

  class PharmacyPageState extends State<PharmacyPage> {
    late Future<List<GeneralPharmacyResult>> _pharmacyFuture;

    @override
    void initState() {
      super.initState();
      _pharmacyFuture = _fetchPharmacy();
    }

    Future<List<GeneralPharmacyResult>> _fetchPharmacy() async {
      PharmacyApiService apiService = PharmacyApiService();
      return await apiService.fetchPharmacy();
    }
    Future<void> _refreshPharmacy() async {
      setState(() {
        _pharmacyFuture = _fetchPharmacy();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Pharmacy".tr()),
          backgroundColor: Colors.red[900],
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
      onRefresh: _refreshPharmacy,
      child: FutureBuilder<List<GeneralPharmacyResult>>(
      future: _pharmacyFuture,
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
      List<GeneralPharmacyResult>? weatherList = snapshot.data;
      return ListView.builder(
      itemCount: weatherList!.length,
      itemBuilder: (context, index) {
      GeneralPharmacyResult pharmacyItem = weatherList[index];
                      return Card(
                        color: Colors.red.shade900,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            '${pharmacyItem.name ?? ''} ECZANESİ',
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 50),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pharmacyItem.address ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                  '0${pharmacyItem.phone ?? ''} ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                pharmacyItem.dist ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold
                                ),
                              )
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
      ),
      );
    }
  }
