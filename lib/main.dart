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

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Startup Name Generator'),
      actions: [
        new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
      ],
    ),
    body: _buildSuggestions(),
  );

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) => new ListTile(
              title: new Text(pair.asPascalCase, style: _biggerFont)));
          final divided = ListTile
              .divideTiles(context: context, tiles: tiles)
              .toList();
          return new Scaffold(
            appBar: new AppBar(title: new Text('Saved Suggestions')),
            body: new ListView(children: divided));
        }
      )
    );
  }

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

  _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    final iconData = alreadySaved ? Icons.favorite : Icons.favorite_border;
    final color = alreadySaved ? Colors.red : null;
    return new ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont),
      trailing: new Icon(iconData, color: color),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }
}
