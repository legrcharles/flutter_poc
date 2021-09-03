import 'dart:async';

import 'package:rxdart/rxdart.dart';

class CounterViewModel {

  // Subjects

  BehaviorSubject<int> _counterSubject;
  Stream<int> get counterStream => _counterSubject.stream;

  // Init

  CounterViewModel({int initialCount = 0})
      : _counterSubject = BehaviorSubject<int>.seeded(initialCount);

  // Dispose

  void dispose() {
    _counterSubject.close();
  }

  // Events

  void onIncrementButtonTapped() {
    _counterSubject.sink.add(_counterSubject.value + 1);
  }
}