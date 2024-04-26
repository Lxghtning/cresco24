import 'package:flutter/material.dart';
import 'package:cresco24/Components/NavBar.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = ["1","2","3","4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#174ac2"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: NavBar(),
        body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
          children: [
            const SizedBox(height: 150.0),
            Align(
              alignment:  Alignment.center,
              child: Text(
            "This is a question",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
        ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child :ListTile(
                    title: Text(items[index]),
                      onTap: (){

                      }
                  ),

                );
              },
            ),
            ),
        ]

      ),
        ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: null,
      ),
    );
  }
}
