import 'package:flutter/material.dart';

class PinPad extends StatefulWidget {
  @override
  _PinPadState createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> {
  List<int> _values;
  String _input = "";

  final TextStyle buttonTextStyle =
      TextStyle(fontSize: 30.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "ENTER PIN",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: Iterable
                      .generate(
                          4,
                          (n) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                n >= _input.length
                                    ? Icons.panorama_fish_eye
                                    : Icons.lens,
                                size: 16.0,
                                color: Colors.white,
                              )))
                      .toList()),
            ),
            _buildRow([1, 2, 3], context),
            _buildRow([4, 5, 6], context),
            _buildRow([7, 8, 9], context),
            _buildLastRow()
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<int> inputs, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: inputs
            .map((value) => FlatButton(
                  child: Text(
                    value.toString(),
                    style: buttonTextStyle,
                  ),
                  highlightColor: Colors.transparent,
                  onPressed: () => addInput(value.toString()),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(23.0),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLastRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => clearInput(),
            textColor: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.all(23.0),
          ),
          FlatButton(
            child: Text(
              "0",
              style: buttonTextStyle,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => addInput("0"),
            shape: CircleBorder(),
            padding: EdgeInsets.all(23.0),
          ),
          FlatButton(
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => removeInput(),
            textColor: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.all(23.0),
          ),
        ],
      ),
    );
  }

  void addInput(String value) {
    setState(() {
      if (_input.length == 0) {
        _input = value;
      } else if (_input.length <= 3) {
        _input += value;
        if (_input.length == 3) {
          // validate pin
        }
      }
    });
  }

  void removeInput() {
    setState(() {
      if (_input.length == 0) {
        _input = "";
      } else {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void clearInput() {
    setState(() {
      _input = "";
    });
  }
}
