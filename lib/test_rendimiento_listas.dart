import 'dart:collection';

int calculate() {
  return 6 * 7;
}

void mediciones(int cant) {

  print('Resultados para $cant elementos');

  final List<String> nombres = List.generate(100, (index) => 'Nombre $index');

  medirTiempo('lista 1', () {
    final lista1 = [...nombres, 'lista1'];
  });

  medirTiempo('lista 2', () {
    final lista2 = List.of(nombres).add('lista2');
  });

  medirTiempo('lista 3', () {
    nombres.add('lista3');
    final lista3 = UnmodifiableListView(nombres);
  });
  
}

void medirTiempo(String operationName, void Function() operation) {
  final stopwatch = Stopwatch()..start();
  operation();
  stopwatch.stop();
  print('$operationName tardó: ${stopwatch.elapsedMicroseconds} us');
}
