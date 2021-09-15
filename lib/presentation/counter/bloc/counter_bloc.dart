import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/quiz_datamanager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  final DataManager _dataManager;

  CounterBloc(this._dataManager) : super(CounterState(value: _dataManager.counterValue));

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    dev.log("SignInBloc Transition :\ncurrentState : ${transition.currentState.toString()} \n"
        "event : ${transition.event.toString()} \n"
        "nextState : ${transition.nextState.toString()}");
    super.onTransition(transition);
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      final newValue = state.value + 1;
      yield state.copyWith(value: newValue);
      add(CounterChanged(value: newValue));
    } else if (event is Reset) {
      yield state.copyWith(value: 0);
      add(const CounterChanged(value: 0));
    } else if (event is CounterChanged) {
      _dataManager.saveCounter(event.value);
    }
  }
}

// State

class CounterState extends Equatable {
  final int value;

  const CounterState({
    this.value = 0
  });

  CounterState copyWith({ int? value}) =>
      CounterState(
        value: value ?? this.value
      );

  @override
  List<Object> get props => [value];

}

// Events

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class Increment extends CounterEvent {}

class Reset extends CounterEvent {}

class CounterChanged extends CounterEvent {
  const CounterChanged({required this.value});

  final int value;

  @override
  List<Object> get props => [value];
}