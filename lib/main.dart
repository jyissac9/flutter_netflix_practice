import 'package:flutter/material.dart';
import 'package:flutter_netflix_practice/screen/home_screen.dart';
import 'package:flutter_netflix_practice/screen/like_screen.dart';
import 'package:flutter_netflix_practice/screen/more_screen.dart';
import 'package:flutter_netflix_practice/screen/search_screen.dart';
import 'package:flutter_netflix_practice/screen/stored_screen.dart';
import 'package:flutter_netflix_practice/widget/bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Pratice with Firebase',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: MyScreen(),
      ),
    );
  }
}

Widget MyScreen() {
  return Scaffold(
    body: TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeScreen(),
        SearchScreen(),
        StoredScreen(),
        MoreScreen(),
      ],
    ),
    bottomNavigationBar: Bottom(),
  );
}