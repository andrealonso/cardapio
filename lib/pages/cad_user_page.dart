import 'dart:io';
import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/pages/inicial_page.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:cardapio/util/validacoes.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../util/constantes.dart';

class CadUserPage extends StatefulWidget {
  final PerfilUsuarioModel usuario;
  final bool editar;

  const CadUserPage({Key key, this.usuario, this.editar = false})
      : super(key: key);

  @override
  _CadUserPageState createState() => _CadUserPageState();
}

class _CadUserPageState extends State<CadUserPage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _picker = ImagePicker();
  File file;
  bool _visivel = false;

  var nome = '';
  var sobrenome = '';
  var usuario = '';
  var senha1 = '';
  var senha2 = '';

  _cadastrarUsuario() async {
    try {
      var usuarioCadastrado = await _auth.createUserWithEmailAndPassword(
          email: usuario.trim(), password: senha1);

      var _perfilNovo = PerfilUsuarioModel(
          nome: nome,
          sobrenome: sobrenome,
          uid: usuarioCadastrado.user.uid,
          usuario: usuario);

      var _perfilCadastrado =
          await UsuarioService().criarPerfil(_perfilNovo, image: file);
      GetIt.I<UserController>().setUsuario(_perfilCadastrado);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      print(_perfilCadastrado);
    } catch (e) {
      print(e);
    }
  }

  _atualizarUsuario() async {
    try {
      var _perfilNovo = PerfilUsuarioModel(
          img: imageAvatarPadrao,
          nome: nome,
          sobrenome: sobrenome,
          uid: widget.usuario.uid,
          usuario: widget.usuario.usuario);

      var _perfilCadastrado =
          await UsuarioService().atualizarPerfil(_perfilNovo, image: file);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      print(_perfilCadastrado);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userEdit = widget.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de usuário'),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
        ),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius:
                                          2.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          1, // has the effect of extending the shadow
                                      offset: Offset(
                                        3, // horizontal, move right 10
                                        6.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: showImage(userEdit),
                                      fit: BoxFit.cover)),
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
                  height: 20,
                ),
                Container(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Nome',
                  ),
                  initialValue: widget.editar ? userEdit.nome : null,
                  validator: (value) {
                    return Validacao().tamanho(value, 2);
                  },
                  onSaved: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),
                Container(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Sobrenome',
                  ),
                  initialValue: widget.editar ? userEdit.sobrenome : null,
                  validator: (value) {
                    Validacao().vazio(value);
                  },
                  onSaved: (value) {
                    setState(() {
                      sobrenome = value;
                    });
                  },
                ),
                Visibility(
                  visible: !widget.editar,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          labelText: 'Usuário (Seu email)',
                        ),
                        validator: (value) {
                          return Validacao().email(value);
                        },
                        onSaved: (value) {
                          setState(() {
                            usuario = value;
                          });
                        },
                      ),
                      Container(
                        height: 40,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          labelText: 'Senha',
                        ),
                        validator: (value) {
                          return Validacao().tamanho(value, 8);
                        },
                        onSaved: (value) {
                          setState(() {
                            senha1 = value;
                          });
                        },
                      ),
                      Container(
                        height: 40,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          labelText: 'Confirmar senha',
                        ),
                        validator: (value) {
                          return Validacao().tamanho(value, 8);
                        },
                        onSaved: (value) {
                          setState(() {
                            senha2 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Visibility(
                    visible: _visivel,
                    child: Text(
                      'As senhas não conferem',
                      style: TextStyle(color: Colors.red),
                    ),
                    replacement: Text(
                      'Usuario ou senha inválida!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                ),
                BotaoWidget(
                  nome: widget.editar ? 'Atualizar' : 'Cadastrar',
                  clicar: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                      setState(() {
                        _visivel = !Validacao().confirmarSenha(senha1, senha2);
                      });

                      if (widget.editar) {
                        _atualizarUsuario();
                      } else {
                        _cadastrarUsuario();
                      }
                    }
                  },
                ),
                Container(
                  height: 40,
                ),
                Visibility(
                  visible: widget.editar,
                  child: BotaoWidget(
                    cor: Colors.red[600],
                    nome: 'Excluir',
                    clicar: () {
                      print('Clicou em excluir');
                      _excluir(userEdit);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _excluir(PerfilUsuarioModel usuario) async {
    await UsuarioService().excluir(usuario);
    print('Usuario excluído com sucesso!');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Inicial()));
  }

  ImageProvider showImage(PerfilUsuarioModel usuario) {
    if (file != null) {
      return FileImage(file);
    } else {
      if (usuario != null && usuario.img != null) {
        return NetworkImage(usuario.img);
      } else {
        return AssetImage(imageAvatarPadrao);
      }
    }

    // setState(() {});
  }

  chooseImage() async {
    var image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 85, maxWidth: 640);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }
}
