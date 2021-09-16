import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataStateInitial extends DataState {}

class DataStateLoading extends DataState {}

class DataStateSuccess extends DataState {}

class DataStateEmpty extends DataState {}

class DataStateLoaded<T extends Object> extends DataState {
  const DataStateLoaded({required this.data});

  final T data;

  @override
  List<Object> get props => [data];
}

class DataStateError extends DataState {
  const DataStateError({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}

/*
class DataWrapper<T> {
  DataWrapperState state;

  DataWrapper.loading() : state = StateLoading();

  DataWrapper.empty() : state = StateEmpty();

  DataWrapper.data(T data)
      : state = StateData(data);

  DataWrapper.error(Object error)
      : state = StateError(error);


  TResult when<TResult extends Object?>({
        required TResult Function() initial,
        required TResult Function() empty,
        required TResult Function() loading,
        required TResult Function(T data) data,
        required TResult Function(Object failure) error,
      }) {
    if (state is StateInitial) {
      return initial();
    } else if (state is StateEmpty) {
      return empty();
    } else if (state is StateLoading) {
      return loading();
    } else if (state is StateData) {
      return data(state.data);
    }
  }

}

class SuccessWrapper {
  DataWrapperState state;

  SuccessWrapper.loading() : state = StateLoading();

  SuccessWrapper.success() : state = StateSuccess();

  SuccessWrapper.error(Object error)
      : state = StateError(error);

}

abstract class DataWrapperState {}

class StateLoading extends DataWrapperState {}
class StateEmpty extends DataWrapperState {}
class StateSuccess extends DataWrapperState {}
class StateData<T> extends DataWrapperState {
  final T data;

  StateData(this.data);
}
class StateError extends DataWrapperState {
  final Object error;

  StateError(this.error);
}


*/
/*
class DataWrapper<T> {

  DataWrapper._();

  factory DataWrapper.initial() = StateInitial;

  factory DataWrapper.loading() = StateLoading;

  factory DataWrapper.empty() = StateEmpty;

  factory DataWrapper.data(T data) = StateData;

  factory DataWrapper.error(Object error) = StateError;


  TResult when<TResult extends Object?>(
      TResult Function(T value) $default, {
        required TResult Function() initial,
        required TResult Function() empty,
        required TResult Function() loading,
        required TResult Function(Object failure) error,
      }) {
    return error(error);
  }

  R use<R extends DataWrapper>(
      R Function() useStateInitial,
      R Function() useStateData) {

    if (this is StateInitial) {
      return useStateInitial();
    } else if (this is StateData) {
      return useStateData();
    }
    throw Exception('Invalid state');
  }

}


class StateInitial<T> extends DataWrapper<T> {
  StateInitial() : super._();
}
class StateLoading<T> extends DataWrapper<T> {
  StateLoading() : super._();
}
class StateEmpty<T> extends DataWrapper<T> {
  StateEmpty() : super._();
}
class StateData<T> extends DataWrapper<T> {
  final T _data;

  get data => _data;

  StateData(this._data): super._();
}
class StateError<T> extends DataWrapper<T> {
  final Object error;

  StateError(this.error): super._();
}

*/
