import 'package:cardapio/widgets/textos_widget.dart';
import 'package:flutter/material.dart';

class AvaliacaoItem extends StatelessWidget {
  final String texto;
  final int valor;

  Icon IconeEstrela(int val) {
    return val == 1
        ? Icon(
            Icons.star,
            color: Color(0xff777777),
          )
        : Icon(
            Icons.star_border,
            color: Color(0xffaaaaaa),
          );
  }

  const AvaliacaoItem({Key key, this.texto, this.valor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            texto,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                (valor >= 1 ? IconeEstrela(1) : IconeEstrela(0)),
                (valor >= 2 ? IconeEstrela(1) : IconeEstrela(0)),
                (valor >= 3 ? IconeEstrela(1) : IconeEstrela(0)),
                (valor >= 4 ? IconeEstrela(1) : IconeEstrela(0)),
                (valor >= 5 ? IconeEstrela(1) : IconeEstrela(0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
