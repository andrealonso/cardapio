class EstabelecimentoModal {
  String uid;
  String tipoUser;
  String nome;
  String endereco;
  String cep;
  String horaAbre;
  String horaFecha;
  String usuario;
  String senha;
  String descricao;
  String tiposComidas;
  String outrosTipos;
  String img;
  int likes;
  bool onfavorito = false;
  bool onlike = false;

  EstabelecimentoModal(
      {this.uid,
      this.nome,
      this.endereco,
      this.cep,
      this.horaAbre,
      this.horaFecha,
      this.descricao,
      this.tiposComidas,
      this.outrosTipos,
      this.img,
      this.likes = 0,
      this.onfavorito,
      this.onlike});

  EstabelecimentoModal.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nome = json['nome'];
    endereco = json['endereco'];
    cep = json['cep'];
    horaAbre = json['horaAbre'];
    horaFecha = json['horaFecha'];
    descricao = json['descricao'];
    tiposComidas = json['tiposComidas'];
    outrosTipos = json['outrosTipos'];
    img = json['img'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['endereco'] = this.endereco;
    data['cep'] = this.cep;
    data['horaAbre'] = this.horaAbre;
    data['horaFecha'] = this.horaFecha;
    data['descricao'] = this.descricao;
    data['tiposComidas'] = this.tiposComidas;
    data['outrosTipos'] = this.outrosTipos;
    data['img'] = this.img;
    data['likes'] = this.likes;
    return data;
  }
}
