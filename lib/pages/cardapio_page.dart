import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/pages/cad_produto_page.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cardapio/widgets/card_produto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CardapioPage extends StatefulWidget {
  final EstabelecimentoModal estab;

  const CardapioPage({Key key, this.estab}) : super(key: key);
  @override
  _CardapioPageState createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
  List<ProdutoModel> listaProdutos = [];
  List<ProdutoModel> listaFiltrada = [];
  @override
  void initState() {
    super.initState();
    _exibirProdutos();
  }

  _exibirProdutos() async {
    listaProdutos = await ProdutoService().listarProdutos(widget.estab.uid);
    setState(() {});
  }

  _addProduto() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CadProduto(
              estab: widget.estab,
            )));
  }

  List<ProdutoModel> _filtrar(List<ProdutoModel> lista) {
    setState(() {
      lista = lista.where((f) => f.onfavorito).toList();
    });
    return lista;
  }

  _buscarNome(List<ProdutoModel> lista, String value) {
    if (value.length > 0) {
      listaFiltrada = lista
          .where((f) => f.nome.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      listaFiltrada = lista.where((f) => f.nome.isNotEmpty).toList();
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    return Scaffold(
      floatingActionButton: (usuarioAtual.uid == widget.estab.uid)
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _addProduto,
            )
          : Container(),
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
                      return CardProdutoWidget(
                        produto: data,
                        estab: widget.estab,
                      );
                    }).toList(),
                  ),
                )
              ]),
            ),
    );
  }
}
