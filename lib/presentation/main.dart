import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/presentation/screens/second_screen.dart';
import 'package:flutter_practices/presentation/screens/third_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  ///StatefulWidget LIFECYCLE. #https://flutterbyexample.com/lesson/stateful-widget-lifecycle
  /// Flutter is instructed to build a StatefulWidget, it immediately calls createState(). This method must exist. like ==onCreate() android
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// note: if use case needs only 1 unique / SINGLE INSTANCE  for all the screens, then init below variableCubit
  var _counterCubit = CounterTestCubit();

  ///initState is called once and only once
  /// suit for initialize data & properties that rely on this widget
  @override
  void initState() {
    log("_MyAppState: initState");
    super.initState();
  }

  ///The didChangeDependencies method is called immediately after initState on the first time the widget is built.
  @override
  void didChangeDependencies() {
    log("_MyAppState: didChangeDependencies");
  }

  ///A MUST method is called often (UI renders). It is a required, @override and must return a Widget.
  /// Remember that in Flutter all GUI is a widget with a child or children inside here!!
  @override
  Widget build(BuildContext context) {
    log("_MyAppState: build UI");

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
          '/': (context) => BlocProvider.value(
                value: _counterCubit,
                child:
                    HomeScreen(title: 'MY FLUTTER APP', color: Colors.blueGrey),
              ),
          '/2': (context) => BlocProvider.value(
                value: _counterCubit,
                child: SecondScreen(
                  title: 'Second Screen',
                  colorApp: Colors.red,
                ),
              ),
          '/3': (context) => BlocProvider.value(
                value: _counterCubit,
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

  /// this will called if the parent widget changes and has to rebuild this widget (because it needs to give it different data),
  /// but it's being rebuilt with the same runtimeType, then this method is called.
  @override
  void didUpdateWidget(MyApp oldWidget) {
    log("_MyAppState: didUpdateWidget");
  }

  /// setState = used to notify the "data has changed", & the widget at this build context should be rebuilt.
  /// callback cannot be async, hence need to repaint the UI
  @override
  void setState(VoidCallback fn) {
    log("_MyAppState: setState");
  }

  /// dispose is called when the State object is removed, which is permanent.
  /// This method is where to unsubscribe and cancel all animations, streams, etc.
  @override
  void dispose() {
    log("_MyAppState: dispose");
    _counterCubit.close();
    super.dispose();
  }
}
