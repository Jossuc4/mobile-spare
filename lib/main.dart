import 'package:flutter/material.dart';
import 'package:oscapp/models/data_storage.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'package:oscapp/models/login_provider.dart';
import 'package:oscapp/models/plafond_provider.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:oscapp/utils/notification_service.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:oscapp/screen/authentification/login.dart';
import 'package:oscapp/screen/authentification/welcome.dart';
import 'package:oscapp/screen/home.dart';
import 'package:oscapp/screen/splash/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Ensure the path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();

  // Create an instance of DataStorage
  final dataStorage = DataStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlafondProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider(dataStorage)),
        ChangeNotifierProvider(create: (_) => FetchDataProvider()),
        ChangeNotifierProvider(create: (_) => DataStorage()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSC APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const MyHomePage(isDrawerVisible: false),
      },
      home: const _AppStart(),
    );
  }
}

class _AppStart extends StatefulWidget {
  const _AppStart({Key? key}) : super(key: key);

  @override
  __AppStartState createState() => __AppStartState();
}

class __AppStartState extends State<_AppStart> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login = prefs.getString('login');
    String? password = prefs.getString('password');

    if (login != null &&
        password != null &&
        login.isNotEmpty &&
        password.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/splash').then((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
