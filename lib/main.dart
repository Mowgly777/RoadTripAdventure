import 'package:flutter/material.dart';
import 'package:road_trip_adventure/providers/loginProvider.dart';
import 'package:road_trip_adventure/screens/homePage/home_page.dart';
import 'package:road_trip_adventure/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Road Trips',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(title: 'Trip Summaries'),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key, required this.title});

  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  Future<bool> tokenPresent = Future(() async {

    bool loggedIn = await isLoggedIn();
    return loggedIn;
  });

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: tokenPresent, 
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('Error'),));
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.data == true) {
          return Homepage();
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.data == false) {
          return LoginForm();
        }

        return const Scaffold(body: CircularProgressIndicator());
      },
    );
    
  }
}
