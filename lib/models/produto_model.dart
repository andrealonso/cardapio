import 'dart:ffi';

class ProdutoModel {
  String uid;
  String nome;
  String img;
  String descricao;
  String composicao;
  double preco;
  int likes;

  ProdutoModel(
      {this.uid,
      this.nome,
      this.img,
      this.descricao,
      this.composicao,
      this.preco,
      this.likes});

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nome = json['nome'];
    img = json['img'];
    descricao = json['descricao'];
    composicao = json['composicao'];
    if (json['preco'] != null) {
      preco = json['preco'] is double
          ? json['preco']
          : double.tryParse(json['preco']);
    }
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['img'] = this.img;
    data['descricao'] = this.descricao;
    data['composicao'] = this.composicao;
    data['preco'] = this.preco;
    data['likes'] = this.likes;
    return data;
  }
}
