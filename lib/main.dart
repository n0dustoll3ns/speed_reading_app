import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:speed_reading_app/animated_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speed reading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Speed reading'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  String generatedText = lorem(paragraphs: 1, words: 100);
  String currentWord = 'screen';
  final Duration duration = Duration(milliseconds: 222);
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    super.initState();
  }

  Future<void> _speedShow() async {
    List<String> words = generatedText.split(' ');
    for (var word in words) {
      setState(() {
        currentWord = word;
      });
      await _controller.forward();
      _controller.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text(generatedText)),
            const Divider(),
            Expanded(
              child: Center(
                child: AnimatedText(
                  text: currentWord,
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speedShow,
        tooltip: 'generate',
        child: const Icon(Icons.receipt_outlined),
      ),
    );
  }
}
