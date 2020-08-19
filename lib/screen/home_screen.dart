import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_netflix_practice/model/model_movie.dart';
import 'package:flutter_netflix_practice/screen/like_screen.dart';
import 'package:flutter_netflix_practice/widget/box_slider.dart';
import 'package:flutter_netflix_practice/widget/carousel_slider.dart';
import 'package:flutter_netflix_practice/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return Container(
        child: ListView(
          children: <Widget>[
            MyTapBar(),
            Stack(
              children: <Widget>[
                CarouselImage(movies: movies),
              ],
            ),
            CircleSlider(
              movies: movies,
            ),
            BoxSlider(
              movies: movies,
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class MyTapBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/logo_netflix.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          FlatButton(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
          FlatButton(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
          FlatButton(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<Null>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return LikeScreen();
                  }));
            },
          ),
        ],
      ),
    );
  }
}
