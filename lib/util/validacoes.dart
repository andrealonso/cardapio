class Validacao {
  final String texto;

  Validacao({this.texto});

  String vazio(String value) {
    if (value.isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  String tamanho(String value, int qtd) {
    if (value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else {
      if (value.length < qtd) {
        return 'Este campo precisa ter no mínimo $qtd dígitos';
      }
    }
    return null;
  }

  String email(String value) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value);
    
    if (value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else {
      if (!emailValid){
        return 'O endereço do email não é válido';
      }
    }
    return null;
  }

  bool confirmarSenha(String senha1, String senha2){
    return senha1==senha2;
    return null;
  }
}
