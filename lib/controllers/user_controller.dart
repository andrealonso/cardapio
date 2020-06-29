import 'package:mobx/mobx.dart';
import '../models/usuario_modal.dart';
part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  PerfilUsuarioModel usuarioAtual;

  @action
  void setUsuario(PerfilUsuarioModel usuario){
    usuarioAtual = usuario;
  }
}