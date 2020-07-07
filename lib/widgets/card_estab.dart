import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/estab_view_page.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:cardapio/widgets/favoritoEstab_wiget.dart';
import 'package:cardapio/widgets/imgCache.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ItemWidget extends StatefulWidget {
  final EstabelecimentoModal estab;
  final Function clickCard;

  ItemWidget({this.estab, this.clickCard});

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    var _estab = widget.estab;

    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EstabView(
                  estab: _estab,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        color: Colors.white,
        margin: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              child: FittedBox(
                fit: BoxFit.cover,
                child: ImgCache(img: _estab.img),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.estab.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: [
              FavoritoEstabWidget(
                estab: _estab,
              ),
              _estab.onlike
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
                      }),
              Text(_estab.likes.toString()),
            ]),
          ],
        ),
      ),
    );
  }
}
