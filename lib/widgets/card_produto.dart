import 'package:cardapio/models/produto_model.dart';
import 'package:flutter/material.dart';

class CardProdutoWidget extends StatelessWidget {
  final ProdutoModel produto;
  final Function clickCard;
  final bool favorito;

  CardProdutoWidget({this.produto, this.clickCard, this.favorito});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickCard,
      child: Container(
        padding: EdgeInsets.only(left: 3, right: 3),
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
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                color: Colors.red[50],
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      produto.composicao,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(child: Text(produto.preco.toString()),)
          ],
        ),
      ),
    );
  }
}
