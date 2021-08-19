import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<MyHomePage> {
  List<List> _matrix;

  _HomePageState() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = '';
      }
    }
    _intiMatrix();
  }

  _intiMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = '';
      }
    }
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tok Toe"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _builtElement(0, 0),
              _builtElement(0, 1),
              _builtElement(0, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _builtElement(1, 0),
              _builtElement(1, 1),
              _builtElement(1, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _builtElement(2, 0),
              _builtElement(2, 1),
              _builtElement(2, 2),
            ],
          )
        ],
      )),
    );
  }

  String _lastChar = '0';
  int i;
  int j;

  _builtElement(i, j) {
    return GestureDetector(
      onTap: () {
        _changeValue(i, j);
        _chaeckWinner(x, y);
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _changeValue(i, j) {
    setState(() {
      if (_matrix[i][j] == '') {
        if (_lastChar == '0')
          _matrix[i][j] = 'x';
        else
          _matrix[i][j] = '0';
        _lastChar = _matrix[i][j];
      }
    });
  }

  int x, y;

  _chaeckWinner(x, y) {
    var col = 0, row = 0, diag = 0, rdig = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) {
        col++;
      }
      if (_matrix[i][y] == player) {
        row++;
      }
      if (_matrix[i][i] == player) {
        diag++;
      }
      if (_matrix[i][n - 1] == player) {
        rdig++;
      }
      if (row == n + 1 || col == n + 1 || diag == n + 1 || rdig == n + 1) {
        _showDialogWin(player);
      }
    }
  }

  _showDialogWin(String winner) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Game Over"),
            content: Text("Player $winner Win"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _intiMatrix();
                  setState(() {
                    _intiMatrix();
                  });
                },
                child: Text("Reset Button"),
                shape: Border.all(color: Colors.blue),
              )
            ],
          );
        });
  }
}
