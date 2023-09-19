// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/contador_codegen/contador_codegen_controller.dart';

class ContageCodeGenPage extends StatefulWidget {
  const ContageCodeGenPage({super.key});

  @override
  State<ContageCodeGenPage> createState() => _ContageCodeGenPageState();
}

class _ContageCodeGenPageState extends State<ContageCodeGenPage> {
  final controller = ContadorCodegenController();
  final reactionsDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();

    // Autorun fica escutando as variaveis que estao sendo usada dentro deles
    // e também roda logo quando criado!
    final autoRunDisposer = autorun((_) {
      print('----------- auto run -------------');
      print(controller.fullName.first);
      // print(controller.fullName.last);
    });

    // reaction nós falamos para o mobx qual o atributo observavel que queremos observar!!
    final reactionDisposer = reaction((_) => controller.counter, (counter) {
      print('------------- reaction ------------');
      print(counter);
    });

    final whenDisposer =
        when((_) => controller.fullName.first == 'Fabrício', () {
      print('------------- reaction ------------');
      print(controller.fullName.first);
    });

    reactionsDisposer.add(autoRunDisposer);
    reactionsDisposer.add(reactionDisposer);
    reactionsDisposer.add(whenDisposer);
  }

  @override
  void dispose() {
    for (var reaction in reactionsDisposer) {
      reaction();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Contador MobX CodeGen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.first);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.last);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.saudacao);
              },
            ),
            TextButton(
              onPressed: () => controller.changeName(),
              child: const Text('Change Name'),
            ),
            TextButton(
              onPressed: () => controller.rollBackName(),
              child: const Text('RollBack Name'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
