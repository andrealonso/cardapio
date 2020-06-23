import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/services/produto_serv.dart';
import 'package:cardapio/widgets/avaliacao_item_widget.dart';
import 'package:cardapio/widgets/textos_widget.dart';
import 'package:flutter/material.dart';

class ProdutoViewPage extends StatefulWidget {
  @override
  _ProdutoViewPageState createState() => _ProdutoViewPageState();
}

class _ProdutoViewPageState extends State<ProdutoViewPage> {
  final service = ProdutoService();
  ProdutoModel produto;

  @override
  void initState() {
    super.initState();
    _carregarProduto();
  }

  _carregarProduto() async {
    final resp = await service.getProduto();
    setState(() {
      produto = resp;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Nome do Estabelecimento',
            style: TextStyle(color: Color(0xff777777)),
          ),
          backgroundColor: Colors.white),
    body:produto==null ? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffcccccc)),
              ),
              child: Image.network(produto.img, fit: BoxFit.cover),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(produto.nome, style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.share, color: Colors.black45),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.red),
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
            SizedBox(height: 10),
            Titulo(texto: produto.preco.toString()),
            SizedBox(
              height: 10,
            ),
            Titulo(texto: 'Descrição'),
            Paragrafo(texto: produto.descricao),
            SizedBox(height: 10),
            Titulo(texto: 'Composição'),
            Paragrafo(texto: produto.composicao),
            SizedBox(height: 10),
            Titulo(texto: 'Avaliação'),
            // AvaliacaoItem(texto: 'Apresentação', valor: produto.avaliacao.apresentacao),
            // AvaliacaoItem(texto: 'Sabor', valor: produto.avaliacao.sabor),
            // AvaliacaoItem(texto: 'Preço', valor: produto.avaliacao.preco),
            // AvaliacaoItem(texto: 'Tempo de preparo', valor: produto.avaliacao.tempo),
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
