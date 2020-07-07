import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FavoritoProdutoWidget extends StatefulWidget {
  final ProdutoModel produto;
  const FavoritoProdutoWidget({Key key, this.produto}) : super(key: key);

  @override
  _FavoritoEstabWidgetState createState() => _FavoritoEstabWidgetState();
}

class _FavoritoEstabWidgetState extends State<FavoritoProdutoWidget> {
  @override
  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    var _produto = widget.produto;

    var _espera = false;
    if (_espera) {
      return CircularProgressIndicator();
    } else {
      return _produto.onfavorito
          ? IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () async {
                setState(() {});
                await UsuarioService()
                    .delProdutoFavorito(usuarioAtual.uid, _produto);
                print('del estab favorito');
                setState(() {
                  _produto.onfavorito = false;
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
                    .addProdutoFavorito(usuarioAtual.uid, _produto);
                print('add estab favorito');
                setState(() {
                  _espera = false;
                  _produto.onfavorito = true;
                });
              },
            );
    }
  }
}
