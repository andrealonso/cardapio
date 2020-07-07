import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FavoritoEstabWidget extends StatefulWidget {
  final EstabelecimentoModal estab;

  const FavoritoEstabWidget({Key key, this.estab}) : super(key: key);

  @override
  _FavoritoEstabWidgetState createState() => _FavoritoEstabWidgetState();
}

class _FavoritoEstabWidgetState extends State<FavoritoEstabWidget> {
  @override
  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    var _estab = widget.estab;

    var _espera = false;
    if (_espera) {
      return CircularProgressIndicator();
    } else {
      return _estab.onfavorito
          ? IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () async {
                setState(() {});
                await UsuarioService()
                    .delEstabFavorito(usuarioAtual.uid, _estab);
                print('del estab favorito');
                setState(() {
                  _estab.onfavorito = false;
                });
              },
            )
          : IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.red),
              onPressed: () async {
                setState(() {
                  _espera = true;
                });
                await UsuarioService()
                    .addEstabFavorito(usuarioAtual.uid, _estab);
                print('add estab favorito');
                setState(() {
                  _espera = false;
                  _estab.onfavorito = true;
                });
              },
            );
    }
  }
}
