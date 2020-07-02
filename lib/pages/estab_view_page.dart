import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/cardapio_page.dart';
import 'package:cardapio/widgets/avaliacao_item_widget.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:cardapio/widgets/textos_widget.dart';
import 'package:flutter/material.dart';

class EstabView extends StatelessWidget {
  final EstabelecimentoModal estab;

  const EstabView({Key key, this.estab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Text(estab.nome),
              background: Image.network(
                estab.img,
                fit: BoxFit.cover,
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
                          
                          IconButton(
                            icon:
                                Icon(Icons.favorite_border, color: Colors.red),
                            onPressed: () {},
                          ),
                          Column(
                            children: <Widget>[
                              Icon(Icons.thumb_up, color: Colors.blue),
                              Text('345')
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
                  Paragrafo(texto: estab.descricao),
                  SizedBox(height: 10),
                  Titulo(texto: 'Local'),
                  Paragrafo(texto: estab.endereco),
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
            largura: 150,
            clicar: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => CardapioPage(
              //           estab: estab,
              //         )));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CardapioPage(
                        estab: estab,
                      )));

            },
          ),
          BotaoWidget(
            nome: 'Local',
            largura: 150,
            clicar: () {},
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
