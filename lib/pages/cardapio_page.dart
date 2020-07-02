import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/cad_produto_page.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cardapio/widgets/card_produto.dart';
import 'package:flutter/material.dart';

class CardapioPage extends StatefulWidget {
  final EstabelecimentoModal estab;

  const CardapioPage({Key key, this.estab}) : super(key: key);
  @override
  _CardapioPageState createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
List<Map<String,dynamic>> listaProdutos;
  @override
  void initState() {
    super.initState();
    _exibirProdutos();
  
  }

  _exibirProdutos() async {
    listaProdutos = await ProdutoService().listarProdutos(widget.estab.uid);
    setState(() {});
  }
  _addProduto(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> CadProduto(estab: widget.estab,)));
  }

   Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addProduto,
      ),
      appBar: AppBar(
        title: Text(widget.estab?.nome),
        centerTitle: true,
      ),
      body: listaProdutos == null
          ? CircularProgressIndicator()
          : Container(
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
                            hintText: 'Pesquisar produtos'),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.search), onPressed: null)
                  ]),
                ),
                Expanded(
                  child: ListView(
                    children: listaProdutos.map((data) {
                      return CardProdutoWidget(produto: data["produto"],id: data["id"],estab: widget.estab,);
                    }).toList(),
                  ),
                )
              ]),
            ),
    );
  }
}
