import 'package:flutter/material.dart';
import 'package:news/models/general_prayer_time_result.dart';
import 'package:news/services/prayer_time_api_service.dart';

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
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Namaz Vakitleri'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.blueGrey],
          ),
        ),
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
                        color: Colors.lime[200],
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
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              prayerTimeItem.saat ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
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