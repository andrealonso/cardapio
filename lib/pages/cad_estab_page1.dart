import 'dart:io';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/cad_estab_page2.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadEstabStep1 extends StatefulWidget {
  final EstabelecimentoModal estab;
  final bool editar;

  const CadEstabStep1({Key key, this.estab, this.editar = false})
      : super(key: key);

  @override
  _CadEstabStep1State createState() => _CadEstabStep1State();
}

class _CadEstabStep1State extends State<CadEstabStep1> {
  final formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  final _picker = ImagePicker();
  File file;

  ImageProvider showImage() {
    if (file != null) {
      return FileImage(file);
    } else {
      if (widget.estab != null && widget.estab.img != null) {
        return NetworkImage(widget.estab.img);
      } else {
        return AssetImage("assets/images/img-estab-padrao.png");
      }
    }
  }

  chooseImage() async {
    var image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 85, maxHeight: 800);
    setState(() {
      file = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _estab = widget.estab == null ? EstabelecimentoModal() : widget.estab;

    return Scaffold(
      appBar: AppBar(
        title: widget.editar
            ? Text('Alterar estabelecimento')
            : Text('Cadastrar estabelecimento'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: showImage(), fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: chooseImage,
                              child: Icon(Icons.photo_camera)),
                        ],
                      ),
                    ),
                  ],
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
                    _estab.nome = value;
                    // perfilAtual.nome = value;
                  },
                  initialValue: _estab?.nome,
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
                    _estab.endereco = value;
                  },
                  initialValue: _estab != null ? _estab.endereco : null,
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
                    _estab.cep = value;
                  },
                  initialValue: _estab != null ? _estab.cep : null,
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
                    _estab.horaAbre = value;
                  },
                  initialValue: _estab != null ? _estab.horaAbre : null,
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
                    _estab.horaFecha = value;
                  },
                  initialValue: _estab != null ? _estab.horaFecha : null,
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
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CadEstabStep2(
                              estab: _estab,
                              file: file != null ? file : null,
                              editar: widget.editar,
                            )));
                  }
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
