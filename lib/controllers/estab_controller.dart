import 'package:mobx/mobx.dart';
import '../models/estabelecimento_modal.dart';
part 'estab_controller.g.dart';

class EstabController = _EstabControllerBase with _$EstabController;

abstract class _EstabControllerBase with Store {
  @observable
  EstabelecimentoModal estabAtual;

  @action
  void setEstab(EstabelecimentoModal estab){
    estabAtual = estab;
  }
  
  
}