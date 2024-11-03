import 'dart:async' show Future;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = "n.a.";

  _loadData() {
    _loadRemoteData().then((String result) {
      setState(() {
        _result = result;
      });
    });
  }

  Future<String> _loadRemoteData() async {
    final response = await (http.get(Uri.parse('https://oreil.ly/ndCPN')));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('response statusCode is 200');
      }
      return response.body;
    } else {
      if (kDebugMode) {
        print('Http Error: ${response.statusCode}!');
      }
      throw Exception('Invalid data source.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Pushed the button to load data.',
            ),
            Semantics(
                child: Text(
                  _result,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Load data',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
