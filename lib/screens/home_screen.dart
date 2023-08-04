import 'package:flutter/material.dart';
import 'package:news/screens/register_page.dart';
import 'package:news/services/news_api_service.dart';
import '../models/general_news_result.dart';
import 'detail_page.dart';
import 'language_option.dart';
import 'login_page.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GeneralNewsResult>> _newsFuture;
  String currentLanguageCode = 'tr';
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
  Future<void> _refreshNews()async{
    setState(() {
      _newsFuture = _fetchNews();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('HABERLER'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey,
        child: ListView(
          children: [
            ListTile(
              title: const Text('ANA SAYFA'),
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
            const Divider(),
            ListTile(
              title: const Text('Dil Seç'),
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
                        elevation: 4,
                        color: Colors.black38,
                        child: Hero(
                          tag: "newsItem_$index",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            newsItem.image != null
                                ? Image.network(
                                newsItem.image!,
                                width: 200,
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
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    newsItem.description ?? '',
                                    style: const TextStyle(fontSize: 2),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black38,
            icon: Icon(Icons.login),
            label: 'Giriş Yap',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Kayıt Ol',
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ),
      );
    }
  }
}
