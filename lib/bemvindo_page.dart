import 'package:flutter/material.dart';

class Bemvindo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 160,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Seja bem vindo ao \nCardápio Online',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 37, color: Color(0xff777777)),
            ),
            Container(
              height: 100,
            ),
            Container(
              height: 60,
              width: 300,
              alignment: Alignment.center,
              child: Text(
                'Acessar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff0076EB),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            Container(
              height: 50,
            ),
            Container(
              height: 60,
              width: 300,
              alignment: Alignment.center,
              child: Text(
                'Cadastrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff0076EB),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
