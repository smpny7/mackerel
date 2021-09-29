import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'controller/bar_chart_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic response;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _getResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 300),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  "https://coalabo.net",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 20,
                  child: ElevatedButton(
                    onPressed: () => _getResponse(),
                    child: const Icon(Icons.refresh,
                        color: Colors.lightBlueAccent),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(height: 15),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200.0,
                maxWidth: 340.0,
              ),
              child: response == null
                  ? Container(height: 300)
                  : BarChart(
                      BarChartController().getBarChartData(response),
                      swapAnimationDuration: const Duration(milliseconds: 150),
                      swapAnimationCurve: Curves.linear,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getResponse() async {
    var uri = Uri.parse('http://localhost:8080/getLogs/ETa9GtS9bl3Xc6JzFkTu');
    var response = await http.get(uri);
    setState(() => this.response = json.decode(response.body));
  }
}
