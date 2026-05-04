import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent (bloc, event);
    developer.log('Event: ${event.runtimeType}', name: 'BLOC');
  }

  @override
  void onChange (BlocBase bloc, Change change) {
    super.onChange (bloc, change);
    developer.log(
      'Change: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      name: 'BLOC',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      'Error: $error',
      name: 'BLOC',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}