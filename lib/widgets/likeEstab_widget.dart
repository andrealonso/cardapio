import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:flutter/material.dart';

class LikeEstabWidget extends StatefulWidget {
  final EstabelecimentoModal estab;
  final PerfilUsuarioModel usuario;

  const LikeEstabWidget({Key key, this.estab, this.usuario}) : super(key: key);
  @override
  _LikeEstabWidgetState createState() => _LikeEstabWidgetState();
}

class _LikeEstabWidgetState extends State<LikeEstabWidget> {
  @override
  Widget build(BuildContext context) {
    var _estab = widget.estab;
    return _estab.onlike
        ? IconButton(
            icon: Icon(
              Icons.thumb_up,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                if (_estab.likes > 0) {
                  _estab.likes--;
                }
                _estab.onlike = !_estab.onlike;
              });
            })
        : IconButton(
            icon: Icon(
              Icons.thumb_up,
              color: Colors.black38,
            ),
            onPressed: () {
              setState(() {
                _estab.likes++;
                _estab.onlike = !_estab.onlike;
              });
            });
  }
}
