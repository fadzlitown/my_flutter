import 'package:flutter_bloc/flutter_bloc.dart';

///global init debugging through all the states & providers
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    print(cubit);
    super.onCreate(cubit);
  }

  @override
  void onClose(Cubit cubit) {
    print(cubit);
    super.onClose(cubit);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(cubit);
    super.onChange(cubit, change);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }
}
