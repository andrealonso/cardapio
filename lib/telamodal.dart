import 'package:flutter/material.dart';

class TelaModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          RaisedButton(child: Text('Opção 1'), onPressed: null),
          RaisedButton(child: Text('Opção 2'), onPressed: null),
        ],
      ),
    );
  }
}