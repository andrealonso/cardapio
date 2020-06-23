import 'package:cardapio/controllers/estab_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/services/cad_stab_service.dart';
import 'package:cardapio/services/estab_firestore_service.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CadEstabStep2 extends StatefulWidget {
  final EstabelecimentoModal estabNovo;

  const CadEstabStep2({Key key, this.estabNovo}) : super(key: key);
  @override
  _CadEstabStep2State createState() => _CadEstabStep2State();
}

class _CadEstabStep2State extends State<CadEstabStep2> {
  final formkey = GlobalKey<FormState>();
  var perfilAtual = GetIt.I<EstabController>().estabAtual;
  final _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  var perfilNovo = PerfilUsuarioModel();
  var _estabNovo = EstabelecimentoModal();
  

  final listaComidas = [
    {'nome': 'Pizza', 'ativo': false},
    {'nome': 'Carne', 'ativo': true},
    {'nome': 'Saladas', 'ativo': true},
    {'nome': 'Buffer', 'ativo': false},
    {'nome': 'Vegana', 'ativo': false},
    {'nome': 'Prato executivo', 'ativo': false},
    {'nome': 'Massas', 'ativo': true},
    {'nome': 'Lanche', 'ativo': true},
    {'nome': 'Frutos do mar', 'ativo': true},
    {'nome': 'Frango', 'ativo': true},
    {'nome': 'Outros', 'ativo': true}
  ];

  List<ItemComidas> lista = [];

  _CadEstabStep2State();

  void addLista() {
    listaComidas.forEach((f) {
      lista.add(ItemComidas(
        nome: f['nome'],
        ativo: f['ativo'],
        clicar: () {
          setState(() {
            f['ativo'] = !f['ativo'];
          });
        },
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    // if (widget.estabNovo != null) {
    //   _estabNovo = widget.estabNovo;
    // }
    print(perfilAtual.nome);
    addLista();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de estabelecimento'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    'Descreva seu restaurante',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    perfilAtual.descricao = value;
                  },
                  initialValue:
                      perfilAtual != null ? perfilAtual.descricao : null,
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Tipos de comidas',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // color: Colors.black12,
                  width: double.infinity,
                  child: Wrap(
                    // alignment: WrapAlignment.start,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: lista,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    perfilAtual.outrosTipos = value;
                  },
                  initialValue:
                      perfilAtual != null ? perfilAtual.outrosTipos : null,
                ),
                SizedBox(
                  height: 30,
                ),
                BotaoWidget(
                  nome: 'Cadastrar',
                  clicar: () {
                    formkey.currentState.save();
                    _cadastrar();
                                       
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

_getUid() async{
  var userAtual = await _auth.currentUser();
  perfilAtual.uid = userAtual.uid; 
}

  _cadastrar() async {
    try {      
      GetIt.I<EstabController>().setEstab(perfilAtual);

      _getUid();

      var _estabCadastrado = CadStabService().cadastrar(perfilAtual);

      print(_estabCadastrado);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e);
    }
  }
}

class ItemComidas extends StatelessWidget {
  final String nome;
  final Function clicar;
  final bool ativo;

  const ItemComidas({this.nome, this.clicar, this.ativo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
        child: Text(
          nome,
          style: TextStyle(
              fontSize: 18, color: ativo == true ? Colors.white : Colors.black),
        ),
        decoration:
            BoxDecoration(color: ativo == true ? Colors.blue : Colors.black12),
      ),
      onTap: clicar,
    );
  }
}
