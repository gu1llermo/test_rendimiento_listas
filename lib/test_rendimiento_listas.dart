import 'dart:collection';

int calculate() {
  return 6 * 7;
}

void mediciones() {
  final cant = 1000;
  //print('Resultados para $cant elementos');
  final cantidadAdicional = 25000;
  final inicio = cant;
  final fin = cant + cantidadAdicional;

  List<String> state1 = List.generate(cant, (index) => 'Index $index');
  print('\n(in) state1.length: ${state1.length}');

  medirTiempo('lista 1', () {
    for (int i = inicio; i < fin; i++) {
      state1 = [...state1, 'Index $i'];
    }
  });
  print('(out) state1.length: ${state1.length}\n');

  List<String> state2 = List.generate(cant, (index) => 'Nombre $index');
  print('(in) state2.length: ${state2.length}');

  medirTiempo('lista 2', () {
    for (var i = inicio; i < fin; i++) {
      state2 = List.of(state2)..add('Index $i');
    }
  });
  print('(out) state2.length: ${state2.length}\n');

  List<String> list3 = List.generate(cant, (index) => 'Nombre $index');
  var state3 = UnmodifiableListView(list3);
  print('(in) state3.length: ${state3.length}');

  medirTiempo('lista 3', () {
    for (var i = inicio; i < fin; i++) {
      list3.add('Index $i');
      state3 = UnmodifiableListView(list3);
    }
  });
  print('(out) state3.length: ${state3.length}\n');
}

void medicionesRoss() {
  List orig = List.generate(1000, (i) => "Index $i");
  final stopwatch = Stopwatch()..start();

  List state = orig; 
  for (int i = 1000; i < 200000; i++) {
    state = [ ...orig, "Index $i"]; 
  }
  print("Spread Operator \t${stopwatch.elapsed.inMilliseconds} ms");

  orig = List.generate(1000, (i) => "Index $i");
  stopwatch.reset();

  state = orig;
  for (int i = 1000; i < 200000; i++) {
    state = List.of(orig)..add("Index $i");
  }
  print("List.of \t\t${stopwatch.elapsed.inMilliseconds} ms");

  orig = List.generate(1000, (i) => "Index $i");
  stopwatch.reset();

  state = UnmodifiableListView(orig);
  for (int i = 1000; i < 200000; i++) {
    orig.add("Index $i");
    state = UnmodifiableListView(orig);
  }
  print("ListView \t\t${stopwatch.elapsed.inMilliseconds} ms");
}

void medicionesRossV2() {
  List<String> orig = List.generate(1000, (i) => "Index $i");
  final stopwatch = Stopwatch()..start();

  List<String> state = orig;

  print('\n(in) orig.length: ${orig.length}');
  print('(in) state.length: ${state.length}');

  for (int i = 1000; i < 200000; i++) {
    state = [ ...orig, "Index $i"]; 
  }
  print("Spread Operator \t${stopwatch.elapsed.inMilliseconds} ms");
  print('(out) state.length: ${state.length}');
  print('(out) orig.length: ${orig.length}\n');

  orig = List.generate(1000, (i) => "Index $i");
  state = orig;
  print('(in) orig.length: ${orig.length}');
  print('(in) state.length: ${state.length}');

  stopwatch.reset();

  for (int i = 1000; i < 200000; i++) {
    state = List.of(orig)..add("Index $i");
  }
  print("List.of \t\t${stopwatch.elapsed.inMilliseconds} ms");
  print('(out) state.length: ${state.length}');
  print('(out) orig.length: ${orig.length}\n');

  orig = List.generate(1000, (i) => "Index $i");
  state = UnmodifiableListView(orig);
  print('(in) state.length: ${state.length}');
  print('(in) orig.length: ${orig.length}');

  stopwatch.reset();

  for (int i = 1000; i < 200000; i++) {
    orig.add("Index $i");
    state = UnmodifiableListView(orig);
  }
  print("ListView \t\t${stopwatch.elapsed.inMilliseconds} ms");
  print('(out) state.length: ${state.length}');
  print('(out) orig.length: ${orig.length}\n');
}



void medirTiempo(String operationName, void Function() operation) {
  final stopwatch = Stopwatch()..start();
  operation();
  stopwatch.stop();
  print('    $operationName tardó: ${stopwatch.elapsedMilliseconds} ms');
}
