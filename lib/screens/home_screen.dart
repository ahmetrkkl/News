import 'package:flutter/material.dart';
import 'package:news/services/news_api_service.dart';
import '../models/general_news_result.dart';
import 'detail_page.dart';
import 'language_option.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GeneralNewsResult>> _newsFuture;
  String currentLanguageCode = 'tr';

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNews();
  }

  Future<List<GeneralNewsResult>> _fetchNews() async {
    NewsApiService apiService = NewsApiService();
    return await apiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('Haberler'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Ana Sayfa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Detail Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Dil Seç'),
              trailing: DropdownButton<String>(
                value: currentLanguageCode,
                onChanged: (selectedLanguageCode) {
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
      body: FutureBuilder<List<GeneralNewsResult>>(
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
                  return ListTile(
                    title: Text(newsItem.name ?? ''),
                    subtitle: Text(newsItem.description ?? ''),
                    leading: newsItem.image != null
                        ? Image.network(newsItem.image!)
                        : const SizedBox.shrink(),
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
    );
  }
}
