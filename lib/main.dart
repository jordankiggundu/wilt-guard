import 'package:flutter/material.dart';
import 'package:wiltguard/controllers/user_controller.dart';
import './views/start_page.dart';
import '/views/login.dart';
import 'views/sign_up.dart';
import 'views/home.dart';
import 'views/explore.dart';
import 'views/chat.dart';
import 'views/account.dart';
import 'views/components/my_bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AAAAmYoBRaM:APA91bGrjoHKt8Co8yRSTvzmLLRuUykxVVGqPhzCVoQ69k6c-ruSxXEUjdPbkSpE9H2c7siOkeZQ_AmQvtbDF9mnF9KhyAEpUfq-PCw3fb3wuibI3UdhjM8V-OaW2D4HwY4A_y4yL_dK",
      appId: "1:659445335459:android:d792ab8b6b14ea45c70616",
      messagingSenderId: "659445335459",
      projectId: "wilt-guard-project",
    ),
  );
  // await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Wilt Guard",
        initialRoute: '/',
        routes: {
          "/": (context) => const StartPage(),
          '/login': (context) => const Login(),
          '/signup': (context) => const SignUp(),
          '/home': (context) => const MainPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const Home(),
    const Explore(),
    const Chat(),
    const Account()
  ];

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
