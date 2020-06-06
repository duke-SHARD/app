import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() => runApp(MyApp()); // entry point for all dart files

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorial Name Generator',
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.blueAccent)
    );
  }
}

class RandomWordsState extends State<RandomWords> { // for the RandomWords widget
  final List<WordPair> _suggestions = <WordPair>[]; // If it starts with a '_', only visible inside the library Array of type WordPair
  final TextStyle _fontSize = TextStyle(fontSize: 18);
  final Set<WordPair> _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('TEST Name Generator'),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.ac_unit), onPressed: _pushSaved)
    ]),
    body: _buildSuggestions());
  }
  void _pushSaved() {
    var route = MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) => ListTile(title: Text(pair.asCamelCase, style: _fontSize)));
      final List<Widget> dividedTiles = ListTile
      .divideTiles(context: context, tiles: tiles)
      .toList();
      return Scaffold(appBar: AppBar(title: Text('Saved')), body: ListView(children: dividedTiles));
    });
    Navigator.of(context).push(route);
  }
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider();
        }
        final index = i ~/ 2; // integer divide by 2
        if (index >= _suggestions.length) {
          final Iterable<WordPair> wordPairs = generateWordPairs().take(10);
          _suggestions.addAll(wordPairs);
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    final bool isSaved = _saved.contains(pair);
    return ListTile(title: Text(pair.asPascalCase, style: _fontSize), trailing: 
    Icon(isSaved ? Icons.favorite : Icons.favorite_border,
    color: isSaved ? Colors.red[300] : null),
    onTap: () {
      setState(() {
        if (isSaved) {
          _saved.remove(pair);
        } else {
          _saved.add(pair);
        }
      });
    });
  }
}

class RandomWords extends StatefulWidget { // stateful means it has state and can change
  @override
  RandomWordsState createState() => RandomWordsState();
}