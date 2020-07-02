import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/pages/cardapio_page.dart';
import 'package:cardapio/pages/estab_view_page.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:cardapio/widgets/item_estab.dart';
import 'package:cardapio/widgets/menu_drawner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../util/constantes.dart';

class HomePage extends StatefulWidget {
  // final List<Widget> itens = [];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titulo = '';
  var estabelecimentos = [];
  final _perfilserve = UsuarioService();
  var usuarioAtual = PerfilUsuarioModel();
  List listaEstabs = [];

  _exibirLista() async {
    listaEstabs = await EstabService().listarEstabs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _exibirLista();
  }

  Widget build(BuildContext context) {
    final usuarioAtual = GetIt.I<UserController>().usuarioAtual;

    return usuarioAtual == null
        ? Espera()
        : Scaffold(
            backgroundColor: corBackgroud,
            drawer: MenuDrawerWidget(),
            appBar: AppBar(
              title: Observer(builder: (_) {
                return Text('Bem vindo: ${usuarioAtual?.nome}');
              }),
              centerTitle: true,
            ),
            body: Container(
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
                      children: listaEstabs.map((estab) {
                    return ItemWidget(
                      estab: estab,
                      km: '2km',
                      likes: 123,
                      favorito: false,
                      clickCard: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EstabView(
                                  estab: estab,
                                )));
                      },
                    );
                  }).toList()),
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                print('Filtrar');
              },
              child: Icon(
                Icons.filter_list,
                size: 34,
              ),
              elevation: 20,
            ),
          );
  }
}

class Espera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
