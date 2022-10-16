import 'package:flutter/material.dart';
import 'package:half_circle_progress_bar/half_circle_progress_bar/half_circle_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
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
  double _progress = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                HalfCircleProgressBar(
                  progress: _progress,
                  dotColor: const Color.fromARGB(255, 119, 198, 255),
                  progressDotColor: const Color.fromARGB(255, 28, 160, 255),
                ),
                Text("${(_progress * 100).toInt()}%"),
              ],
            ),
            const SizedBox(height: 12),
            Slider(
              value: _progress,
              min: 0.0,
              max: 1.0,
              onChanged: (progress) => setState(() => _progress = progress),
            ),
          ],
        ),
      ),
    );
  }
}
