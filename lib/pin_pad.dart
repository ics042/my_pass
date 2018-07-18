import 'package:flutter/material.dart';

class PinPad extends StatefulWidget {
  PinPad({@required this.isSignUp});

  final bool isSignUp;
  @override
  _PinPadState createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> {
  List<int> _values;
  bool _isShowPinNumber = false;

  final TextStyle buttonTextStyle =
      TextStyle(fontSize: 30.0, color: Colors.white);

  @override
  void initState() {
    super.initState();
    _values = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Please Enter PIN",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
          _buildPinHolder(),
          _buildKeyPad(context)
        ],
      ),
    );
  }

  Widget _buildPinHolder() {
    return !widget.isSignUp
        ? Padding(
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
                              n >= _values.length
                                  ? Icons.panorama_fish_eye
                                  : Icons.lens,
                              size: 16.0,
                              color: Colors.white,
                            )))
                    .toList()),
          )
        : Stack(
            alignment: const Alignment(0.5, 0.5),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildOnePinNumber(0),
                  _buildOnePinNumber(1),
                  _buildOnePinNumber(2),
                  _buildOnePinNumber(3),
                ],
              ),
              _buildShowPinNumberIcon()
            ],
          );
  }

  Widget _buildShowPinNumberIcon() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              _isShowPinNumber = !_isShowPinNumber;
            });
          }),
    );
  }

  Widget _buildOnePinNumber(int i) {
    String number;
    if (_isShowPinNumber && _values.length > i) {
      number = _values[i].toString();
    } else if (!_isShowPinNumber && _values.length > i) {
      number = "*";
    } else {
      number = " ";
    }
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      width: 20.0,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child:
          Text(number, style: TextStyle(fontSize: 20.0, color: Colors.white)),
    );
  }

  Widget _buildKeyPad(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRow([1, 2, 3], context),
        _buildRow([4, 5, 6], context),
        _buildRow([7, 8, 9], context),
        _buildLastRow(context)
      ],
    );
  }

  Widget _buildRow(List<int> inputs, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: inputs
            .map((value) => FlatButton(
                  child: Text(
                    value.toString(),
                    style: buttonTextStyle,
                  ),
                  highlightColor: Colors.transparent,
                  onPressed: () => _addInput(value, context),
                  shape: CircleBorder(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLastRow(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => _clearInput(),
            textColor: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
          ),
          FlatButton(
            child: Text(
              "0",
              style: buttonTextStyle,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => _addInput(0, context),
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
          ),
          FlatButton(
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
            highlightColor: Colors.transparent,
            onPressed: () => _removeInput(),
            textColor: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
          ),
        ],
      ),
    );
  }

  void _addInput(int value, BuildContext context) {
    if (_values.length < 4) {
      setState(() {
        _values.add(value);
        if (widget.isSignUp) {
          if (_values.length == 4) {
            _confirmPinNumber(context);
          }
        } else if (_values.length == 4) {}
      });
    }
  }

  void _removeInput() {
    if (_values.length > 0) {
      setState(() {
        _values.removeLast();
      });
    }
  }

  void _clearInput() {
    setState(() {
      _values = [];
    });
  }

  void _confirmPinNumber(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              child: new Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  child: ListTile(
                    title: Text("Please confirm the PIN"),
                    trailing: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18.0),
                        )),
                  )));
        });
  }
}
