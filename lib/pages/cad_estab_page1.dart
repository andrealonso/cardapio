import 'dart:io';

import 'package:cardapio/controllers/estab_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/cad_estab_page2.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class CadEstabStep1 extends StatefulWidget {
  @override
  _CadEstabStep1State createState() => _CadEstabStep1State();
}

class _CadEstabStep1State extends State<CadEstabStep1> {
  final formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  EstabelecimentoModal perfilAtual;
  var _estabNovo = EstabelecimentoModal();
  final _picker = ImagePicker();
  File file;

  void cadStep1() {
    _estabNovo.img =
        'https://www.infomoney.com.br/wp-content/uploads/2019/06/pizza-2.jpg';
    GetIt.I<EstabController>().setEstab(_estabNovo);
  }

  Widget showImage() {
    if (file != null) {
      return Image.file(file, fit: BoxFit.cover);
    } else {
      return FittedBox(
        child: Icon(
          Icons.photo,
          color: Colors.blue,
        ),
      );
    }
    return Container();
  }

  chooseImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
    // if (perfilAtual == null) {
    //   GetIt.I<EstabController>().setEstab(EstabelecimentoModal());
    //   print(GetIt.I<EstabController>().estabAtual);
    // }
    // perfilAtual = GetIt.I<EstabController>().estabAtual;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de estabelecimentos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: Center(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5),
                          width: 300,
                          height: 187,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: showImage()),
                      Positioned(
                          bottom: -30,
                          right: -40,
                          child: GestureDetector(
                            child: Icon(
                              Icons.photo_camera,
                              size: 35,
                              color: Colors.blue,
                            ),
                            onTap: chooseImage,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome do estabelecimento',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estabNovo.nome = value;
                    // perfilAtual.nome = value;
                  },
                  initialValue: perfilAtual?.nome,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estabNovo.endereco = value;
                  },
                  initialValue:
                      perfilAtual != null ? perfilAtual.endereco : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estabNovo.cep = value;
                  },
                  initialValue: perfilAtual != null ? perfilAtual.cep : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Horário de abertura',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estabNovo.horaAbre = value;
                  },
                  initialValue:
                      perfilAtual != null ? perfilAtual.horaAbre : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Horário de fechamento',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estabNovo.horaFecha = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              BotaoWidget(
                nome: 'Avançar',
                clicar: () {
                  formkey.currentState.save();

                  cadStep1();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CadEstabStep2(
                            estabNovo: _estabNovo,
                          )));
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
