import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logMessage('onCreate ${bloc.toString()}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logMessage("onEvent ${bloc.toString()} -> ${event?.toString() ?? "-"}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logMessage('onError ${bloc.toString()} -> ${error.toString()}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logMessage('onChange ${bloc.toString()} -> ${change.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logMessage('onTransition ${bloc.toString()} -> ${transition.toString()}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logMessage('onClose ${bloc.toString()}');
  }

  void _logMessage(String message) {
    final logger = Logger();
    logger.i(message);
  }
}
