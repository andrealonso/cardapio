class PerfilUsuarioModel {
  String nome;
  String sobrenome;
  String uid;
  String img;
  String usuario;

  PerfilUsuarioModel(
      {this.nome, this.sobrenome, this.uid, this.img, this.usuario});

  PerfilUsuarioModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];

    sobrenome = json['sobrenome'];
    uid = json['uid'];
    img = json['img'];
    usuario = json['usuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['uid'] = this.uid;
    data['img'] = this.img;
    data['usuario'] = this.usuario;
    return data;
  }
}