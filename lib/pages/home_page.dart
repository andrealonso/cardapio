import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:cardapio/services/cad_stab_service.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/widgets/item_estab.dart';
import 'package:cardapio/widgets/menu_drawner_widget.dart';
import 'package:dio/dio.dart';
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
  final _perfilserve = PerfilUsuarioService();
  PerfilUsuarioModel usuarioAtual;
  List listaEstabs = [];

  _exibirLista() async {
    listaEstabs = await CadStabService().listarEstabs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _perfilserve.getPerfil().then((resp) {
      setState(() {
        usuarioAtual = resp;
      });
      _exibirLista();
    });

    // SharedPreferences.getInstance().then((instance) {
    //   setState(() {
    //     titulo = instance.getString('nome');
    //   });
    // });

    Dio().get('http://www.mocky.io/v2/5eb1b10f320000769428f8f8').then((resp) {
      setState(() {
        estabelecimentos = resp.data;
      });
    });
  }

  Widget build(BuildContext context) {
    final userAtual = GetIt.I<UserController>().usuarioAtual;

    return usuarioAtual == null
        ? Espera()
        : Scaffold(
            backgroundColor: corBackgroud,
            drawer: MenuDrawerWidget(),
            appBar: AppBar(
              title: Observer(builder: (_) {
                return Text('Bem vindo: ${userAtual?.nome}');
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
                    return ItemWidget(estab: estab,
                        km: '2km',
                        likes: 123,
                        favorito: false);
                  }).toList()),
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print('Filtrar');
                // List<EstabelecimentoModal> lista = CadStabService().listEstabs();
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
