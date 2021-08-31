import 'package:equatable/equatable.dart';

class QuestionRequestDto extends Equatable {
  final String type;
  final int amount;
  final int category;

  const QuestionRequestDto(
      {required this.type, required this.amount, required this.category});

  @override
  List<Object> get props => [type, amount, category];

  Map<String, dynamic> toJson() {
    final queryParameters = {
      'type': type,
      'amount': amount,
      'category': category,
    };
    return queryParameters;
  }
}
