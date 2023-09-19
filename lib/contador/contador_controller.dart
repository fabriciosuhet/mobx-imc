// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/new_full_name.dart';

class ContadorController {
  final _counter = Observable<int>(0, name: 'counter observable');
  final _fullName =
      Observable<FullName>(FullName(first: 'first', last: 'last'));
  late Action increment;

  late Computed _saudacaoComputed;

  ContadorController() {
    increment = Action(() {
      _incrementCounter();
    });
    _saudacaoComputed = Computed(() => 'Olá ${_fullName.value.first}');
  }
  int get counter => _counter.value;
  FullName get fullName => _fullName.value;

  String get saudacao => _saudacaoComputed.value;

  void _incrementCounter() {
    _counter.value++;
    // ! Não pode fazer isso, o MobX nao recompila e nao entende
    // _fullName.value.first = 'Fabrício';
    // _fullName.value.last = 'Suhet';

    // ! Opçao 1 alterar por meio de prototype (copywith)
    // ! Trocar isso
    // _fullName.value = FullName(first: 'Fabrício', last: 'Suhet');
    // ! Por:

  }
}

