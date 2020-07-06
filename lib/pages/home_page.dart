import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/pages/estab_view_page.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:cardapio/widgets/card_estab.dart';
import 'package:cardapio/widgets/menu_drawner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titulo = '';
  var estabelecimentos = [];
  var usuarioAtual = PerfilUsuarioModel();
  List<EstabelecimentoModal> listaEstabs = [];
  List<EstabelecimentoModal> listaFiltrada = [];
  bool filtro = false;

  _exibirLista() async {
    listaEstabs = await EstabService().listarEstabs();
    usuarioAtual = await GetIt.I<UserController>().usuarioAtual;
    listaEstabs.forEach((f) {
      f.onfavorito = usuarioAtual.estabsFavoritos.contains(f.uid);
    });

    setState(() {});
  }

  List<EstabelecimentoModal> _filtrar(List<EstabelecimentoModal> lista) {
    setState(() {
      lista = lista.where((f) => f.onfavorito).toList();
    });
    return lista;
  }

  _buscarNome(List<EstabelecimentoModal> lista, String value) async {
    if (value != '') {
      filtro = true;
      listaFiltrada = lista
          .where((f) => f.nome.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      filtro = false;
      // listaFiltrada = lista.where((f) => f.nome.isNotEmpty).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _exibirLista();
    _buscarNome(_filtrar(listaEstabs), '');
  }

  Widget build(BuildContext context) {
    if (filtro) {
      _buscarNome(_filtrar(listaEstabs), '');
    } else {
      listaFiltrada = listaEstabs;
    }
    return usuarioAtual == null
        ? Espera()
        : Scaffold(
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
                        onChanged: (value) {
                          _buscarNome(_filtrar(listaEstabs), value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pesquisar por nome'),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.search), onPressed: null)
                  ]),
                ),
                Expanded(
                  child: ListView(
                      children: listaFiltrada.map((estab) {
                    return ItemWidget(
                      estab: estab,
                    );
                  }).toList()),
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                print(usuarioAtual.estabsFavoritos
                    .contains('krG54WLVpLPMM9UxHu00LmZzv793'));
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
