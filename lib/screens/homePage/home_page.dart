
import 'package:flutter/material.dart';
import 'package:road_trip_adventure/providers/loginProvider.dart';
import 'package:road_trip_adventure/screens/homePage/trip_details.dart';
import 'package:road_trip_adventure/screens/homePage/trip_routes.dart';
import 'package:road_trip_adventure/screens/login_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  Widget _view = TripDetails();

  logout() async {
    await logoutReq();
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) {
          return LoginForm();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Row(
          children: [
            Center(child: Text('Trips')),
            Spacer(),
            IconButton(
              onPressed: logout, 
              icon: Icon(Icons.logout),
            ),
          ] 
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.selected,
            backgroundColor: Colors.lightGreenAccent[100],
            indicatorColor: Colors.lightGreen,
            elevation: 2,
            useIndicator: true,
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
                switch (value) {
                  case 0:
                    _view = TripDetails();
                    break;
                  case 1:
                    _view = TripRoutes();

                }
              });
            },
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.info),
                label: Text('Details'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.route),
                label: Text('Routes'),
              ),
            ],
          ),
          Expanded(
            child: _view
          ),
        ],
      ),
    );
  }
}