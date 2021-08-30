import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/presentation/screens/second_screen.dart';
import 'package:flutter_practices/presentation/screens/third_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// note: if use case needs only 1 unique instance for all the screens, then init below variableCubit
  var _counterCubit = CounterTestCubit();

  @override
  Widget build(BuildContext context) {
    //shortcut Bloc Alt + Enter
    /// below telling flutter to have a single instance of Counter cubit to make it available inside the material widget
    return BlocProvider<CounterTestCubit>(
      create: (context) => CounterTestCubit(),
      child: MaterialApp(
        //Inside MaterialApp() provides the routes !
        routes: {
          /// BlocProvider.value(..) -> Takes a [value] and a [child] which will have access to the [value] via `BlocProvider.of(context)`, & close manually
          /// note: if needs only 1 unique instance for all the screens, then use BlocProvider.value(value: _counterCubit, child..), hence it kept the states
          ///
          /// BlocProvider(create..) -> Takes a [Create] function that is responsible for creating the [Bloc] or [Cubit] & close automatically
          /// BlocProvider(create: (context) => CounterTestCubit(), ..) -> Always create a new instance when its called . hence new states expected
          '/': (context) => BlocProvider(
                create: (context) => CounterTestCubit(),
                child:
                    HomeScreen(title: 'MY FLUTTER APP', color: Colors.blueGrey),
              ),
          '/2': (context) => BlocProvider(
            create: (context) => CounterTestCubit(),
                child: SecondScreen(
                  title: 'Second Screen',
                  colorApp: Colors.red,
                ),
              ),
          '/3': (context) => BlocProvider(
                create: (context) => CounterTestCubit(),
                child:
                    ThirdScreen(title: 'Third Screen', colorApp: Colors.amber),
              ),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home = This is the route that is displayed first when the application is started normally,
        // unless initialRoute is specified. It's also the route that's displayed if the initialRoute can't be displayed.
      ),
    );
  }
}
