import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/exchange_rate_page.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/pharmacy_page.dart';
import 'package:news/screens/prayer_time_page.dart';
import 'package:news/screens/weather_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

 void main ()async {
   WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
    supportedLocales: [Locale('tr', 'TR'), Locale('en', 'US')],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: Locale('tr', 'TR'), startLocale: Locale("tr", "TR"), child: MyApp(),));

}

class MyApp extends StatelessWidget {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: darkTheme, // Başlangıçta aydınlık tema uygula
      home: MyHomePage(),
    );
  }

  static void applyDarkTheme() {
    runApp(MaterialApp(
      theme: darkTheme,
      home: MyHomePage(),
    ));
  }

  static void applyLightTheme() {
    runApp(MaterialApp(
      theme: lightTheme,
      home: MyHomePage(),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 2);

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
            icon: const Icon(Icons.local_pharmacy),
            title: "Eczane",
            activeColorPrimary: Colors.orange.shade400,
            inactiveColorPrimary: Colors.blueGrey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.currency_exchange),
            title: "Döviz",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.blueGrey,
          ),
          PersistentBottomNavBarItem(
              icon: const Icon(
                  Icons.newspaper,
              color: Colors.blueGrey,
              ),
              title: "Haberler",
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: Colors.blueGrey,
              iconSize: 20,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.cloud),
            title: "Hava",
            activeColorPrimary: Colors.green.shade600,
            inactiveColorPrimary: Colors.blueGrey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.mosque),
            title: "Namaz",
            activeColorPrimary: Colors.lime,
            inactiveColorPrimary: Colors.blueGrey,
          ),
        ],
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.blueGrey,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style16,
      ),
    );
  }
}
