import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/pages/cad_produto_page.dart';
import 'package:flutter/material.dart';

class CardProdutoWidget extends StatelessWidget {
  final EstabelecimentoModal estab;
  final ProdutoModel produto;
  final Function clickCard;
  final bool favorito;
  final String id;

  CardProdutoWidget(
      {this.produto, this.clickCard, this.favorito, this.id, this.estab});

  _editar(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CadProduto(
              estab: estab,
              produto: produto,
              editar: true,
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return GestureDetector(
      onTap: () {
        _editar(context);
      },
      child: Container(
        padding: EdgeInsets.only(left: 1, right: 10),
        margin: EdgeInsets.only(top: 2),

        color: Colors.white,
        // margin: EdgeInsets.only(top: 15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              child: produto.img != null
                  ? Image.network(
                      produto.img,
                      fit: BoxFit.cover,
                    )
                  : FittedBox(
                      fit: BoxFit.cover,
                      child: Icon(
                        Icons.photo,
                        color: Colors.black54,
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      produto.composicao,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text("R\$ ${produto.preco.toString()}"),
            )
          ],
        ),
      ),
    );
  }
}
