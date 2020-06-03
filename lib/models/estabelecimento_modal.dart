class EstabelecimentoModal {
  Estabelecimentos estabelecimentos;

  EstabelecimentoModal({this.estabelecimentos});

  EstabelecimentoModal.fromJson(Map<String, dynamic> json) {
    estabelecimentos = json['estabelecimentos'] != null
        ? new Estabelecimentos.fromJson(json['estabelecimentos'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.estabelecimentos != null) {
      data['estabelecimentos'] = this.estabelecimentos.toJson();
    }
    return data;
  }
}

class Estabelecimentos {
  Chave chave;

  Estabelecimentos({this.chave});

  Estabelecimentos.fromJson(Map<String, dynamic> json) {
    chave = json['chave'] != null ? new Chave.fromJson(json['chave']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chave != null) {
      data['chave'] = this.chave.toJson();
    }
    return data;
  }
}

class Chave {
  String nome;
  String descricao;
  String endereco;
  String cep;
  String horaAbre;
  String horaFecha;
  List<Produtos> produtos;
  AvaliacaoEst avaliacaoEst;
  List<CurtidasEst> curtidasEst;

  Chave(
      {this.nome,
      this.descricao,
      this.endereco,
      this.cep,
      this.horaAbre,
      this.horaFecha,
      this.produtos,
      this.avaliacaoEst,
      this.curtidasEst});

  Chave.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    endereco = json['endereco'];
    cep = json['cep'];
    horaAbre = json['hora_abre'];
    horaFecha = json['hora_fecha'];
    if (json['produtos'] != null) {
      produtos = new List<Produtos>();
      json['produtos'].forEach((v) {
        produtos.add(new Produtos.fromJson(v));
      });
    }
    avaliacaoEst = json['avaliacao_est'] != null
        ? new AvaliacaoEst.fromJson(json['avaliacao_est'])
        : null;
    if (json['curtidas_est'] != null) {
      curtidasEst = new List<CurtidasEst>();
      json['curtidas_est'].forEach((v) {
        curtidasEst.add(new CurtidasEst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['endereco'] = this.endereco;
    data['cep'] = this.cep;
    data['hora_abre'] = this.horaAbre;
    data['hora_fecha'] = this.horaFecha;
    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    if (this.avaliacaoEst != null) {
      data['avaliacao_est'] = this.avaliacaoEst.toJson();
    }
    if (this.curtidasEst != null) {
      data['curtidas_est'] = this.curtidasEst.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Produtos {
  String nome;
  int preco;
  String descricao;
  String composicao;
  String img;
  AvaliacaoProd avaliacaoProd;
  List<CurtidasProd> curtidasProd;

  Produtos(
      {this.nome,
      this.preco,
      this.descricao,
      this.composicao,
      this.img,
      this.avaliacaoProd,
      this.curtidasProd});

  Produtos.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    preco = json['preco'];
    descricao = json['descricao'];
    composicao = json['composicao'];
    img = json['img'];
    avaliacaoProd = json['avaliacao_prod'] != null
        ? new AvaliacaoProd.fromJson(json['avaliacao_prod'])
        : null;
    if (json['curtidas_prod'] != null) {
      curtidasProd = new List<CurtidasProd>();
      json['curtidas_prod'].forEach((v) {
        curtidasProd.add(new CurtidasProd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['preco'] = this.preco;
    data['descricao'] = this.descricao;
    data['composicao'] = this.composicao;
    data['img'] = this.img;
    if (this.avaliacaoProd != null) {
      data['avaliacao_prod'] = this.avaliacaoProd.toJson();
    }
    if (this.curtidasProd != null) {
      data['curtidas_prod'] = this.curtidasProd.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvaliacaoProd {
  int apresentacao;
  int sabor;
  int preco;
  int tempo;

  AvaliacaoProd({this.apresentacao, this.sabor, this.preco, this.tempo});

  AvaliacaoProd.fromJson(Map<String, dynamic> json) {
    apresentacao = json['apresentacao'];
    sabor = json['sabor'];
    preco = json['preco'];
    tempo = json['tempo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apresentacao'] = this.apresentacao;
    data['sabor'] = this.sabor;
    data['preco'] = this.preco;
    data['tempo'] = this.tempo;
    return data;
  }
}


class CurtidasProd {
  String uid;
  String nome;
  String img;

  CurtidasProd({this.uid, this.nome, this.img});

  CurtidasProd.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nome = json['nome'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['img'] = this.img;
    return data;
  }
}
class CurtidasEst {
  String uid;
  String nome;
  String img;

  CurtidasEst({this.uid, this.nome, this.img});

  CurtidasEst.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nome = json['nome'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['img'] = this.img;
    return data;
  }
}

class AvaliacaoEst {
  int ambiente;
  int preco;
  int atendimento;
  int tempo;
  int variedade;

  AvaliacaoEst(
      {this.ambiente,
      this.preco,
      this.atendimento,
      this.tempo,
      this.variedade});

  AvaliacaoEst.fromJson(Map<String, dynamic> json) {
    ambiente = json['ambiente'];
    preco = json['preco'];
    atendimento = json['atendimento'];
    tempo = json['tempo'];
    variedade = json['variedade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ambiente'] = this.ambiente;
    data['preco'] = this.preco;
    data['atendimento'] = this.atendimento;
    data['tempo'] = this.tempo;
    data['variedade'] = this.variedade;
    return data;
  }
}

