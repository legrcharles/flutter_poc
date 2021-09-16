import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SuccessWrapper extends Equatable {
  const SuccessWrapper();

  @override
  List<Object> get props => [];
}

class StateInitial extends SuccessWrapper {}

class StateLoading extends SuccessWrapper {}

class StateSuccess extends SuccessWrapper {}

class StateError extends SuccessWrapper {
  const StateError({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
