import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 160,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 300,
              padding: EdgeInsets.only(
                left:15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 15.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Usuário'),
                ),
              
            ),
            Container(
              height: 50,
            ),
            Container(
              height: 50,
              width: 300,
              padding: EdgeInsets.only(
                left:15),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 15.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Senha'),
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
                'Acessar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff0076EB),
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 15.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
