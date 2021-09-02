import 'dart:async';

class CounterViewModel {
  final StreamController<int> _counterStreamController = StreamController<int>();
  int _counter = 0;

  void dispose() {
    _counterStreamController.close();
  }

  Stream<int> get steamCounter => _counterStreamController.stream;

  void initCounter(int counter) {
    _counter = counter;
    _counterStreamController.sink.add(_counter);
  }

  void onIncrementButtonTapped() {
    _counterStreamController.sink.add(++_counter);
  }
}