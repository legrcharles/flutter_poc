class DataWrapper<T> {
  DataWrapperState state;

  DataWrapper.initial() : state = StateInitial();

  DataWrapper.loading() : state = StateLoading();

  DataWrapper.empty() : state = StateEmpty();

  DataWrapper.data(T data)
      : state = StateData(data);

  DataWrapper.error(Object error)
      : state = StateError(error);

  /*
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
   */
}

class SuccessWrapper {
  DataWrapperState state;

  SuccessWrapper.initial() : state = StateInitial();

  SuccessWrapper.loading() : state = StateLoading();

  SuccessWrapper.success() : state = StateSuccess();

  SuccessWrapper.error(Object error)
      : state = StateError(error);

}

abstract class DataWrapperState {}

class StateInitial extends DataWrapperState {}
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
      R Function(StateInitial) useStateInitial,
      R Function(StateData) useStateData) {

    if (this is StateInitial) {
      return useStateInitial(this);
    } else if (this is StateData) {
      return useStateData(this);
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
  T _data;

  get data => _data;

  StateData(this._data): super._();
}
class StateError<T> extends DataWrapper<T> {
  final Object error;

  StateError(this.error): super._();
}


 */
