// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on _UserControllerBase, Store {
  final _$usuarioAtualAtom = Atom(name: '_UserControllerBase.usuarioAtual');

  @override
  PerfilUsuarioModel get usuarioAtual {
    _$usuarioAtualAtom.reportRead();
    return super.usuarioAtual;
  }

  @override
  set usuarioAtual(PerfilUsuarioModel value) {
    _$usuarioAtualAtom.reportWrite(value, super.usuarioAtual, () {
      super.usuarioAtual = value;
    });
  }

  final _$_UserControllerBaseActionController =
      ActionController(name: '_UserControllerBase');

  @override
  void setUsuario(PerfilUsuarioModel usuario) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setUsuario');
    try {
      return super.setUsuario(usuario);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuarioAtual: ${usuarioAtual}
    ''';
  }
}
