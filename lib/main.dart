import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//hello
//allans changes

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Songs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Map<String, dynamic> _songs = {};

  @override
  void initState() {
    getSong();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  getSong() async {
    var header = {
      "x-rapidapi-key": "fad9331ab7msh57e0adfd06210f4p1e03d0jsna603d22f9ab6",
      "x-rapidapi-host": "shazam.p.rapidapi.com"
    };

    Uri url = Uri.parse(
        'https://shazam.p.rapidapi.com/songs/list-recommendations?key=484129036');

    var response = await http.get(url, headers: header);
    _songs = jsonDecode(response.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    if (_songs.isNotEmpty) {
      final List<dynamic> tracks = _songs['tracks'];
      for (int i = 0; i < tracks.length; i++) {
        tiles.add(
          ListTile(
            leading: CircleAvatar(
              radius: 16.0,
              child: ClipRRect(
                child: _songs.isEmpty
                    ? Container(width: 0)
                    : Image.network(tracks[i]['images']['background']),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            title:
                _songs.isEmpty ? Container(width: 0) : Text(tracks[i]['title']),
            subtitle: _songs.isEmpty
                ? Container(width: 0)
                : Text(tracks[i]['subtitle']),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: tiles,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
