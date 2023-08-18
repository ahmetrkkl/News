import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/exchange_rate_page.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
import 'package:news/services/news_api_service.dart';
import '../models/general_news_result.dart';
import 'language_option.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GeneralNewsResult>> _newsFuture;
  String currentLanguageCode = 'en';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNews();
  }

  Future<List<GeneralNewsResult>> _fetchNews() async {
    NewsApiService apiService = NewsApiService();
    return await apiService.fetchNews();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = _fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text('News'.tr()),
      ),
      drawer: Drawer(
        backgroundColor: Colors.red.shade400,
        child: ListView(
          children: [
            ListTile(
              title: Text('News'.tr()),
              onTap: () {
                Navigator.pop(context);
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
            const Divider(),
            ListTile(
              title: Text('Language'.tr()),
              trailing: DropdownButton<String>(
                value: currentLanguageCode,
                onChanged: (selectedLanguageCode) {
                  if(selectedLanguageCode == "en"){
                    context.setLocale(Locale('en', 'US'));
                  }else{
                    context.setLocale(Locale('tr', 'TR'));
                  }
                  setState(() {
                    currentLanguageCode = selectedLanguageCode!;
                  });
                },
                items: languageOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option.code,
                    child: Text(option.name),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: FutureBuilder<List<GeneralNewsResult>>(
          future: _newsFuture,
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
                List<GeneralNewsResult>? newsList = snapshot.data;
                return ListView.builder(
                  itemCount: newsList!.length,
                  itemBuilder: (context, index) {
                    GeneralNewsResult newsItem = newsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(newsItem: newsItem),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          color: Colors.red.shade900,
                          child: Hero(
                            tag: "newsItem_$index",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                newsItem.image != null
                                    ? Image.network(
                                  newsItem.image!,
                                  width: 400,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                                    : const SizedBox.shrink(),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 2),
                                      Text(
                                        newsItem.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        newsItem.description ?? '',
                                        style: const TextStyle(fontSize: 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No news available.'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}