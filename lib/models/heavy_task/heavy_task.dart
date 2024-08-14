import 'package:equatable/equatable.dart';

class HeavyTaskModel extends Equatable {
  final String duration;
  final List<int> randomNumbers;

  const HeavyTaskModel({
    required this.duration,
    required this.randomNumbers,
  });

  @override
  List<Object?> get props => [duration, randomNumbers];

  @override
  String toString() => 'HeavyTaskModel(duration: $duration, randomNumbers: $randomNumbers)';
}
