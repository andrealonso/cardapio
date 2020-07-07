import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/pages/cad_produto_page.dart';
import 'package:cardapio/pages/produto_view_page.dart';
import 'package:cardapio/widgets/imgCache.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CardProdutoWidget extends StatelessWidget {
  final EstabelecimentoModal estab;
  final ProdutoModel produto;
  final Function clickCard;

  CardProdutoWidget({this.produto, this.clickCard, this.estab});

  _viewPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProdutoViewPage(
              produto: produto,
              estab: estab,
            )));
  }

  _editPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            CadProduto(estab: estab, produto: produto, editar: true)));
  }

  @override
  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;

    return ListTile(
        title: Text(produto.nome),
        leading: produto.img != null
            ? Container(
                height: 50,
                width: 60,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ImgCache(img: produto.img),
                ))
            : Container(
                height: 50,
                width: 60,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(
                    Icons.photo,
                    color: Colors.black54,
                  ),
                ),
              ),
        subtitle: Text(produto.composicao),
        trailing: Text("R\$ ${produto.preco}"),
        onTap: () {
          if (usuarioAtual.uid == estab.uid) {
            _editPage(context);
          } else {
            _viewPage(context);
          }
        });
  }
}
