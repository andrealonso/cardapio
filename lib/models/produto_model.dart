class ProdutoModel {
  int _id;
  String _img;
  String _nome;
  String _preco;
  String _descricao;
  String _composicao;
  Avaliacao _avaliacao;
  List<String> _curtidopor;

  ProdutoModel(
      {int id,
      String img,
      String nome,
      String preco,
      String descricao,
      String composicao,
      Avaliacao avaliacao,
      List<String> curtidopor}) {
    this._id = id;
    this._img = img;
    this._nome = nome;
    this._preco = preco;
    this._descricao = descricao;
    this._composicao = composicao;
    this._avaliacao = avaliacao;
    this._curtidopor = curtidopor;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get img => _img;
  set img(String img) => _img = img;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get preco => _preco;
  set preco(String preco) => _preco = preco;
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;
  String get composicao => _composicao;
  set composicao(String composicao) => _composicao = composicao;
  Avaliacao get avaliacao => _avaliacao;
  set avaliacao(Avaliacao avaliacao) => _avaliacao = avaliacao;
  List<String> get curtidopor => _curtidopor;
  set curtidopor(List<String> curtidopor) => _curtidopor = curtidopor;

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _img = json['img'];
    _nome = json['nome'];
    _preco = json['preco'];
    _descricao = json['descricao'];
    _composicao = json['composicao'];
    _avaliacao = json['avaliacao'] != null
        ? new Avaliacao.fromJson(json['avaliacao'])
        : null;
    _curtidopor = json['curtidopor'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['img'] = this._img;
    data['nome'] = this._nome;
    data['preco'] = this._preco;
    data['descricao'] = this._descricao;
    data['composicao'] = this._composicao;
    if (this._avaliacao != null) {
      data['avaliacao'] = this._avaliacao.toJson();
    }
    data['curtidopor'] = this._curtidopor;
    return data;
  }
}

class Avaliacao {
  int _apresentacao;
  int _sabor;
  int _preco;
  int _tempo;

  Avaliacao({int apresentacao, int sabor, int preco, int tempo}) {
    this._apresentacao = apresentacao;
    this._sabor = sabor;
    this._preco = preco;
    this._tempo = tempo;
  }

  int get apresentacao => _apresentacao;
  set apresentacao(int apresentacao) => _apresentacao = apresentacao;
  int get sabor => _sabor;
  set sabor(int sabor) => _sabor = sabor;
  int get preco => _preco;
  set preco(int preco) => _preco = preco;
  int get tempo => _tempo;
  set tempo(int tempo) => _tempo = tempo;

  Avaliacao.fromJson(Map<String, dynamic> json) {
    _apresentacao = json['apresentacao'];
    _sabor = json['sabor'];
    _preco = json['preco'];
    _tempo = json['tempo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apresentacao'] = this._apresentacao;
    data['sabor'] = this._sabor;
    data['preco'] = this._preco;
    data['tempo'] = this._tempo;
    return data;
  }
}