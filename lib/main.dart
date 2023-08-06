import 'package:flutter/material.dart';
import 'package:news/screens/exchange_rate_page.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/settings_page.dart';
import 'package:news/screens/weather_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        hintColor: Colors.grey,
        scaffoldBackgroundColor: Colors.blueGrey,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.grey,
        ),
      ),
      home: const MyHomePage(), // MyHomePage kullanıldı
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          PharmacyPage(),
          ExchangeRatePage(),
          HomeScreen(),
          WeatherPage(),
          PrayerTimePage(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.local_pharmacy),
            title: "ECZANE",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.currency_exchange),
            title: "DÖVİZ",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
              icon: Icon(Icons.add),
              title: "HABERLER",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              iconSize: 30,
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.cloud),
            title: "Hava Durumu",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.mosque),
            title: "Namaz Vakitleri",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0), // Yenilikleri burada yapıyoruz
          colorBehindNavBar: Colors.blueGrey,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
