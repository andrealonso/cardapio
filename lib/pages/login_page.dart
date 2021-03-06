import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:cardapio/util/validacoes.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _service = UsuarioService();
  bool _visivel = false;

  var form_user = '';
  var form_pass = '';
  var user_saved = '';
  var pass_saved = '';
  var logado = false;

  _login() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: form_user.trim(), password: form_pass.trim());

        final usuarioAtual = await _service.getPerfil();
        print('perfil capturado');

        GetIt.I<UserController>().setUsuario(usuarioAtual);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        formkey.currentState.reset();
        if (e.code == 'ERROR_USER_NOT_FOUND') {
          setState(() {
            _visivel = true;
          });
          print('Usuario ou senha inválidas');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((instance) {
      user_saved = instance.getString('usuario');
      pass_saved = instance.getString('senha');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Login'),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
          bottom: 50,
        ),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.local_dining,
                size: 140,
                color: Colors.blue,
              ),
              Text(
                'Tela de Login',
                style: TextStyle(
                  color: Color(0xff777777),
                  fontSize: 28,
                ),
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Usuário (seu email)',
                ),
                onSaved: (value) {
                  form_user = value;
                },
                validator: (value) {
                  Validacao().email(value);
                },
              ),
              Container(
                height: 50,
              ),
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Senha',
                  ),
                  onSaved: (value) {
                    form_pass = value;
                  },
                  validator: (value) {
                    Validacao().tamanho(value, 8);
                  }),
              Container(
                height: 20,
              ),
              Container(
                child: Visibility(
                  visible: _visivel,
                  child: Text(
                    'Usuario ou senha inválida!',
                    style: TextStyle(color: Colors.red),
                  ),
                  replacement: Text(
                    'Usuario ou senha inválida!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              BotaoWidget(
                  nome: 'Acessar',
                  clicar: () {
                    _login();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
