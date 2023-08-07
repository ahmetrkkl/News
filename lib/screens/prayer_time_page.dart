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
        title: const Text('Namaz Vakti'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPrayerTime,
        child: FutureBuilder<List<GeneralPrayerTimeResult>>(
          future: _prayerTimeFuture,
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
                List<GeneralPrayerTimeResult>? prayerTimeList = snapshot.data;
                return ListView.builder(
                  itemCount: prayerTimeList!.length,
                  itemBuilder: (context, index) {
                    GeneralPrayerTimeResult prayerTimeItem = prayerTimeList[index];
                    return ListTile(
                      title: Text(prayerTimeItem.saat ?? ''),
                      subtitle: Text(prayerTimeItem.vakit ?? '')
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