import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/presentation/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ///StatefulWidget LIFECYCLE. #https://flutterbyexample.com/lesson/stateful-widget-lifecycle
  /// Flutter is instructed to build a StatefulWidget, it immediately calls createState(). This method must exist. like ==onCreate() android
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    log("_MyAppState: build UI");

    //shortcut Bloc Alt + Enter
    return BlocProvider<CounterTestCubit>(
      /// below telling flutter to have a single instance of Counter cubit to make it available inside the material widget
      ///
      /// Defining here means it's GLOBALLY ACCESS across ALL OF SCREENS inside MATERIAL APP
      /// created CounterTestCubit() --> used in FIRST & SECOND SCREENS, THIRD SCREEN has a specific BlocProvider Cubit State
      create: (context) => CounterTestCubit(),
      child: MaterialApp(
        //Inside MaterialApp() provides the routes !
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        ///route generator callback used when the app is navigated to a named route
        ///call method only w/o pass anything appRouter.onGenerateRoute
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
