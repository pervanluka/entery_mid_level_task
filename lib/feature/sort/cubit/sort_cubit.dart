import 'dart:isolate';
import 'dart:math';
import 'dart:async';

import 'package:entery_mid_level_task/feature/sort/cubit/sort_state.dart';
import 'package:entery_mid_level_task/models/heavy_task/heavy_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortInitial());

  final stopwatch = Stopwatch();

  Future<void> onButtonPressed() async {
    stopwatch.reset();
    emit(const SortLoading('00:00:00'));
    stopwatch.start();
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(heavyTask, receivePort.sendPort);

    final timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => emit(
        SortLoading(
          _formatTime(stopwatch.elapsed),
        ),
      ),
    );
    receivePort.listen((message) {
      if (message is HeavyTaskModel) {
        emit(SortReady('Time taken: ${message.duration}'));
        timer.cancel();
        receivePort.close();
        isolate.kill(priority: Isolate.immediate);
      } else if (message is Error) {
        emit(const SortError('An error occurred'));
        timer.cancel();
        receivePort.close();
        isolate.kill(priority: Isolate.immediate);
      }
    });
  }
}

void heavyTask(SendPort sendPort) async {
  final stopwatch = Stopwatch()..start();

  try {
    final random = Random();
    final randomNumbers = List.generate(25000000, (_) => random.nextInt(100000));

    quickSort(randomNumbers, 0, randomNumbers.length - 1);

    stopwatch.stop();

    final duration = _formatTime(stopwatch.elapsed);
    final heavyTaskModel = HeavyTaskModel(duration: duration, randomNumbers: randomNumbers);
    sendPort.send(heavyTaskModel);
  } catch (e) {
    sendPort.send(e);
  }
}

String _formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$hours:$minutes:$seconds";
}

void quickSort(List<int> list, int leftIndex, int rightIndex) {
  if (leftIndex < rightIndex) {
    final pivotIndex = partition(list, leftIndex, rightIndex);
    quickSort(list, leftIndex, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, rightIndex);
  }
}

int partition(List<int> list, int leftIndex, int rightIndex) {
  final pivot = list[rightIndex];
  var i = leftIndex - 1;

  for (var j = leftIndex; j < rightIndex; j++) {
    if (list[j] <= pivot) {
      i++;
      final temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  final temp = list[i + 1];
  list[i + 1] = list[rightIndex];
  list[rightIndex] = temp;

  return i + 1;
}
