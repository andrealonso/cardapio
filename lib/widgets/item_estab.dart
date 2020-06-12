import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String nome;
  final String km;
  final int likes;
  final bool favorito;
  final String img;
  final String id;

  ItemWidget(
      {this.img,
      @required this.nome,
      @required this.km,
      @required this.likes,
      @required this.favorito,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
      ),
      color: Colors.white,
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
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
