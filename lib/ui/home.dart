import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchMode = false;
  TextEditingController _searchQuery;
  bool _isSearching = false;

  Timer _timer;
  CancelableOperation _operation;

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
  }

  @override
  void dispose() {
    _stopSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchMode ? _buildSearchField() : _buildTitle(),
        actions: _buildActions(),
      ),
      body: _isSearching ? _buildSearchingBody() : _buildSearchResult(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/add_pass');
          }),
    );
  }

  Widget _buildSearchingBody() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSearchResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.not_interested),
          Text(
            'No Result',
            style: Theme.of(context).textTheme.headline,
          )
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearchMode) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _isSearchMode = false;
              _isSearching = false;
              _searchQuery.text = '';
              _stopSearch();
            });
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearchMode = true;
          });
        },
      ),
    ];
  }

  Widget _buildTitle() {
    return InkWell(
        onTap: () => setState(() {
              _isSearchMode = true;
            }),
        child: Padding(
          padding: EdgeInsets.only(right: 80.0),
          child: Text(
            'My Pass',
            style: Theme
                .of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.white),
          ),
        ));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search pass ...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (String s) => _searchPass(s),
    );
  }

  void _searchPass(String s) {
    _stopSearch();
    if (s.length > 0) {
      _timer = Timer(Duration(milliseconds: 250), () {
        setState(() {
          _isSearching = true;
        });
//      _operation = CancelableOperation.fromFuture();
      });
    } else {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _stopSearch() {
    _timer?.cancel();
    _operation?.cancel();
  }
}
