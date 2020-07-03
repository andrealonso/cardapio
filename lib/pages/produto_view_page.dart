import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cardapio/widgets/avaliacao_item_widget.dart';
import 'package:cardapio/widgets/textos_widget.dart';
import 'package:flutter/material.dart';

class ProdutoViewPage extends StatefulWidget {
  final EstabelecimentoModal estab;
  final ProdutoModel produto;

  const ProdutoViewPage({Key key, this.produto, this.estab}) : super(key: key);
  @override
  _ProdutoViewPageState createState() => _ProdutoViewPageState();
}

class _ProdutoViewPageState extends State<ProdutoViewPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var _produto = widget.produto;
    var _estab = widget.estab;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_estab.nome),
      ),
      body: _produto == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffcccccc)),
                    ),
                    child: Image.network(_produto.img, fit: BoxFit.cover),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              
                              IconButton(
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.red),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Titulo(texto: _produto.nome),
                            Paragrafo(
                                texto: ("R\$ ${_produto.preco.toString()}")),
                          ],
                        ),

                        Titulo(texto: 'Descrição'),
                        Paragrafo(texto: _produto.descricao),

                        Titulo(texto: 'Composição'),
                        Paragrafo(texto: _produto.composicao),

                        Titulo(texto: 'Avaliação'),
                        AvaliacaoItem(texto: 'Apresentação', valor: 3),
                        AvaliacaoItem(texto: 'Sabor', valor:4),
                        AvaliacaoItem(texto: 'Preço', valor: 5),
                        AvaliacaoItem(texto: 'Tempo de preparo', valor: 2),
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
                ],
              ),
            ),
    );
  }
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
