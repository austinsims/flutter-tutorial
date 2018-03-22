import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
    title: 'Welcome to Flutter',
    home: new RandomWords(),
  );
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Startup Name Generator')
    ),
    body: _buildSuggestions(),
  );

  Widget _buildSuggestions() => new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }

        // Get actual index in word pairings, compensating for dividers.
        final index = i ~/ 2;

        // If we're out of available word pairs, generate some more.
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      });

  _buildRow(WordPair pair) =>
      new ListTile(title: new Text(pair.asPascalCase, style: _biggerFont));
}
