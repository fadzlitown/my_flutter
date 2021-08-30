import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/presentation/screens/home_screen.dart';
import 'package:flutter_practices/presentation/screens/second_screen.dart';
import 'package:flutter_practices/presentation/screens/third_screen.dart';

class AppRouter {
  var _counterCubit = CounterTestCubit();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':

      /// (_) identifier meaning it's private to its library.
        return MaterialPageRoute(builder: (_) {
          /// BlocProvider.value(..) -> Takes a [value] and a [child] which will have access to the [value] via `BlocProvider.of(context)`, & close manually
          /// note: if needs only 1 unique instance for all the screens, then use BlocProvider.value(value: _counterCubit, child..), hence it kept the states
          ///
          /// BlocProvider(create..) -> Takes a [Create] function that is responsible for creating the [Bloc] or [Cubit] & close automatically
          /// BlocProvider(create: (context) => CounterTestCubit(), ..) -> Always create a new instance when its called . hence new states expected
          return BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(title: 'MY FLUTTER APP', color: Colors.blueGrey),
          );
        });
        break;
      case '/2':

        /// (_) identifier meaning it's private to its library.
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _counterCubit,
            child: SecondScreen(
              title: 'Second Screen',
              colorApp: Colors.red,
            ),
          );
        });
        break;
      case '/3':

        /// (_) identifier meaning it's private to its library.
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _counterCubit,
            child: ThirdScreen(title: 'Third Screen', colorApp: Colors.amber),
          );
        });
        break;
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
