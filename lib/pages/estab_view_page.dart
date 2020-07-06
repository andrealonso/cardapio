import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/cardapio_page.dart';
import 'package:cardapio/widgets/avaliacao_item_widget.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:cardapio/widgets/favoritoEstab_wiget.dart';
import 'package:cardapio/widgets/imgCache.dart';
import 'package:cardapio/widgets/textos_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EstabView extends StatefulWidget {
  final EstabelecimentoModal estab;

  const EstabView({Key key, this.estab}) : super(key: key);

  @override
  _EstabViewState createState() => _EstabViewState();
}

class _EstabViewState extends State<EstabView> {
  @override
  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    var _estab = widget.estab;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FittedBox(
                fit: BoxFit.cover,
                child: ImgCache(
                  img: widget.estab.img,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FavoritoEstabWidget(
                            usuario: usuarioAtual,
                            estab: _estab,
                          ),
                          Column(
                            children: <Widget>[
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
                              Text(_estab.likes.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Titulo(texto: 'Descrição'),
                  Paragrafo(texto: widget.estab.descricao),
                  SizedBox(height: 10),
                  Titulo(texto: 'Local'),
                  Paragrafo(texto: widget.estab.endereco),
                  SizedBox(height: 10),
                  Titulo(texto: 'Avaliação'),
                  AvaliacaoItem(texto: 'Ambiente', valor: 5),
                  AvaliacaoItem(texto: 'Preços', valor: 3),
                  AvaliacaoItem(texto: 'Atendimento', valor: 1),
                  AvaliacaoItem(texto: 'Variedadte', valor: 2),
                  SizedBox(height: 10),
                  Titulo(texto: 'Curtido por'),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                        CortidaUser(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          BotaoWidget(
            nome: 'Cardápio',
            largura: 200,
            clicar: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CardapioPage(
                        estab: widget.estab,
                      )));
            },
          ),
        ]),
      ),
    );
  }

  Widget CortidaUser() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(border: Border.all()),
      child: Icon(
        Icons.person,
        color: Colors.blue,
      ),
    );
  }
}
