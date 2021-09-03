class DataWrapper<T> {
  DataWrapperState state;

  DataWrapper.initial() : state = StateInitial();

  DataWrapper.loading() : state = StateLoading();

  DataWrapper.empty() : state = StateEmpty();

  DataWrapper.data(T data)
      : state = StateData(data);

  DataWrapper.error(Object error)
      : state = StateError(error);
}

abstract class DataWrapperState {}

class StateInitial extends DataWrapperState {}
class StateLoading extends DataWrapperState {}
class StateEmpty extends DataWrapperState {}
class StateData<T> extends DataWrapperState {
  T data;

  StateData(this.data);
}
class StateError extends DataWrapperState {
  Object error;

  StateError(this.error);
}