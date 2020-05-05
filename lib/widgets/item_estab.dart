import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String nome;
  final String km;
  final int likes;
  final bool favorito;
  final String img;

  ItemWidget(
      {this.img,
      @required this.nome,
      @required this.km,
      @required this.likes,
      @required this.favorito});

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
              padding: const EdgeInsets.only(left:10),
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
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {},
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
