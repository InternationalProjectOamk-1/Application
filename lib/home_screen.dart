import 'package:flutter/material.dart';
import 'package:mapplication/widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const data = {
    "id": 1,
    "description": "City",
    "interests": [3],
    "members": [4],
    "title": "New York",
    "locationBased": true,
    "latitude": 40.7127281,
    "longitude": -74.0060152,
    "hostID": 9,
    "maxPeople": 10,
    "minPeople": 2,
    "startEvent": "2022-03-22T08:39:02.619Z",
    "hasStarted": true
  };

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Feeds",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(data["title"].toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
