import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FormInput extends Equatable {

  final String value;
  final InputStateWrapper? state;

  const FormInput({
    this.value = '',
    this.state
  });

  FormInput copyWith({ String? value, required InputStateWrapper? state }) =>
      FormInput(value: value ?? this.value, state: state);

  @override
  List<Object?> get props => [value, state];

  @override
  String toString() {
    return 'FormInput { value: $value, state: $state }';
  }

  /*
  @override
  String toString() =>
      """FormInput(
        value: $value,
        state: $state)""";

   */
}


@immutable
abstract class InputStateWrapper extends Equatable {
  const InputStateWrapper();

  @override
  List<Object> get props => [];
}

class InputValid extends InputStateWrapper {}

class InputInvalid extends InputStateWrapper {
  const InputInvalid({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}