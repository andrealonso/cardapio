// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estab_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EstabController on _EstabControllerBase, Store {
  final _$estabAtualAtom = Atom(name: '_EstabControllerBase.estabAtual');

  @override
  EstabelecimentoModal get estabAtual {
    _$estabAtualAtom.reportRead();
    return super.estabAtual;
  }

  @override
  set estabAtual(EstabelecimentoModal value) {
    _$estabAtualAtom.reportWrite(value, super.estabAtual, () {
      super.estabAtual = value;
    });
  }

  final _$_EstabControllerBaseActionController =
      ActionController(name: '_EstabControllerBase');

  @override
  void setEstab(EstabelecimentoModal estab) {
    final _$actionInfo = _$_EstabControllerBaseActionController.startAction(
        name: '_EstabControllerBase.setEstab');
    try {
      return super.setEstab(estab);
    } finally {
      _$_EstabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
estabAtual: ${estabAtual}
    ''';
  }
}
