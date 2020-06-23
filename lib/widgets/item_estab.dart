import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final EstabelecimentoModal estab;
  final String nome;
  final String km;
  final int likes;
  final bool favorito;
  final String img;
  final String id;

  ItemWidget(
      {this.img,
      this.nome,
      this.km,
      this.likes,
      this.favorito,
      this.id,
      this.estab});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      color: Colors.white,
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            child: estab.img!=null?Image.network(
              estab.img,
              fit: BoxFit.cover,
            ):Icon(Icons.photo),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    estab.nome,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(km),
                ],
              ),
            ),
          ),
          Column(children: [
            favorito
                ? IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Adicionado nos favoritos'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Removido dos favoritos'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  ),
            Icon(
              Icons.thumb_up,
              color: Colors.blue,
            ),
            Text(likes.toString()),
          ]),
        ],
      ),
    );
  }
}
