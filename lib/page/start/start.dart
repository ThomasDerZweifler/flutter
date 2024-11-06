import 'package:flutter/material.dart';
import 'package:my_app/page/start/repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final startRepo = StartRepository();

  String _result = "n.a.";

  _fab() {
    debugPrint("_fab clicked");
  }

  _loadData() {
    startRepo.loadData().then((String? result) {
      setState(() {
        _result = result ?? "";
      });
    });
  }

  handleClick(String value) {
    switch (value) {
      case 'Load JSON':
        _loadData();
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Load JSON', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'use menu',
            ),
            Semantics(
                child: Text(
                  _result,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fab,
        tooltip: 'FAB action',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
