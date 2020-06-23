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
  Map<String, bool> tiposComidas;
  String outrosTipos;
  String img;

  Map<String, dynamic> mockEstab = {
    'uid': 'testeUID',
    'nome': 'House 82',
    'endereco': 'Rua bla bla bla, 87',
    'cep': '28000100',
    'horaAbre': '18:00',
    'horaFecha': '0:00',
    'usuario': 'andrealonso@hotmail.com',
    'descricao': 'Esse restaurando é muito bom',
    'tiposComidas': [
      {'tipo': 'Pizza', 'ativo': true},
      {'tipo': 'Massa', 'ativo': true},
      {'tipo': 'Peixe', 'ativo': false},
      {'tipo': 'Carne', 'ativo': true}
    ],
    'outrosTipos': 'Camarão, salgados'
  };


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
      this.img});

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
    return data;
  }
}
