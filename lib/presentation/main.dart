import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/logic/internet_cubit.dart';
import 'package:flutter_practices/logic/setting_cubit.dart';
import 'package:flutter_practices/presentation/router/app_router.dart';
import 'package:flutter_practices/utility/AppBlocObserver.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  ///Here is like a Application level of native android

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  ///global init debugging here
  Bloc.observer = AppBlocObserver();

  /// runApp() -> start rendering an app & run the widget tree
  /// MyApp is a ROOT WIDGET
  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  /// These instances does not depends on anything (STAND ALONE)
  /// _appRouter = private members | appRouter = public
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({Key key, @required this.appRouter, @required this.connectivity})
      : super(key: key);

  @override
  Widget build(BuildContext myAppContext) {
    log("_MyAppState: build UI");

    //shortcut Bloc Alt + Enter
    /// this is sample of single BlocProvider return BlocProvider<CounterTestCubit>(

    /// this is sample of MultiBlocProvider
    /// provide these PROVIDERS GLOBALLY inside the app. hence it can access from any screens / widgets
    return MultiBlocProvider(
      providers: [
        /// below telling flutter to have a single instance of Counter cubit to make it available inside the material widget
        ///
        /// Defining here means it's GLOBALLY ACCESS across ALL OF SCREENS inside MATERIAL APP
        /// created CounterTestCubit() --> used in FIRST & SECOND SCREENS, THIRD SCREEN has a specific BlocProvider Cubit State
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterTestCubit>(
          create: (counterCubitContext) => CounterTestCubit(),
        ),
        BlocProvider<SettingCubit>(
          create: (settingContext) => SettingCubit(),

          /// responsible for creating the Bloc or Cubit and a child which will have access
          /// to the instance via BlocProvider.of(context)
          ///
          /// if lazy is true / remove the lazy by default --> this SettingCubit will be only create only if app go to this page. otherwise, it will created every time

          /// (lazy: true / without lazy keyword) - NO SettingCubit instance is being call
          /// I/flutter (30222): Instance of 'CounterTestCubit' & 'InternetCubit'
          ///
          /// (lazy: false) - SettingCubit instance will be called
          /// I/flutter (30222): Instance of 'CounterTestCubit', 'InternetCubit' & 'SettingCubit'
          lazy: true,
        ),
      ],
      child: MaterialApp(
        //Inside MaterialApp() provides the routes !
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        ///route generator callback used when the app is navigated to a named route
        ///call method only w/o pass anything appRouter.onGenerateRoute
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
