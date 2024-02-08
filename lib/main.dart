import 'package:flutter/material.dart';
import './views/start_page.dart';
import '/views/login.dart';
import 'views/sign_up.dart';
import 'views/home.dart';
import 'views/explore.dart';
import 'views/chat.dart';
import 'views/account.dart';
import 'views/components/my_bottom_nav.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wilt Guard",
      initialRoute: '/',
      routes: {
        "/": (context) => const StartPage(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [Home(), Explore(), Chat(), Account()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        widgetOptions: _widgetOptions,
        onTabSelected: _onItemTapped,
      ),
    );
  }
}
