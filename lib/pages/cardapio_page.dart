import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/services/cad_produto_service.dart';
import 'package:cardapio/services/produto_serv.dart';
import 'package:cardapio/widgets/card_produto.dart';
import 'package:flutter/material.dart';

class CardapioPage extends StatefulWidget {
  final EstabelecimentoModal estab;

  const CardapioPage({Key key, this.estab}) : super(key: key);
  @override
  _CardapioPageState createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
  List<ProdutoModel> produtos;

  @override
  void initState() {
    super.initState();
    _exibirProdutos();
  }

  _exibirProdutos() async {
    produtos = await CadProdutoService().listarProdutos(widget.estab.uid);
    setState(() {
      
    });
  }

  Widget build(BuildContext context) {
  
    var estab = widget.estab;

    return Scaffold(
      backgroundColor: Colors.blue[500],
      appBar: AppBar(
        title: Text(estab.nome),
        centerTitle: true,
      ),
      body: produtos==null?CircularProgressIndicator():Container(
        child: Column(children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(children: [
              Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar estabelecimentos'),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: null)
            ]),
          ),
          Expanded(
            child: ListView(
              children: produtos.map((data) {
                return CardProdutoWidget(produto: data);
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}
