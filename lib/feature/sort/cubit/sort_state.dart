import 'package:equatable/equatable.dart';

abstract class SortState extends Equatable {
  const SortState();

  @override
  List<Object> get props => [];
}

class SortInitial extends SortState {}

class SortLoading extends SortState {
  final String elapsedTime;

  const SortLoading(this.elapsedTime);

  @override
  List<Object> get props => [elapsedTime];
}

class SortReady extends SortState {
  final String timeTaken;

  const SortReady(this.timeTaken);

  @override
  List<Object> get props => [timeTaken];
}

class SortError extends SortState {
  final String message;

  const SortError(this.message);

  @override
  List<Object> get props => [message];
}
