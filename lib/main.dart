import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/cubit_test/counter_test_cubit.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //shortcut Bloc Alt + Enter
    //below telling flutter to have a single instance of Counter cubit to make it avaible iniside the material widget
    return BlocProvider<CounterTestCubit>(
      create: (context) => CounterTestCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
          child: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.total}) : super(key: key);

  final String title;
  final String total;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

            //only wrap the intent widget only !! NOT THE WHOLE BODY / Column
            // BlocBuilder + BlocListener = BlocConsumer (will be re-building the UI after the func / event states has changed
            BlocConsumer<CounterTestCubit, CounterTestState>(
                listener: (context, state) {
              // TODO: implement listener
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      state.wasIncremented == true ? 'Increment' : 'Decrement'),
                  duration: Duration(milliseconds: 500)));
            }, builder: (context, state) {
              return Text(state.counterValue.toString());
            }),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    //BlocProvider = what is the user / UI action to a func or event
                    BlocProvider.of<CounterTestCubit>(context).decrement();
                    // BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} #2'),
                  onPressed: () {
                    //BlocProvider = what is the user / UI action to a func or event
                    BlocProvider.of<CounterTestCubit>(context).increment();
                    // BlocProvider.of<CounterCubit>(context).increment();
                    // context.bloc<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                    onPressed: () {
                      //BlocProvider = what is the user / UI action to a func or event
                      BlocProvider.of<CounterTestCubit>(context).multiply();
                    },
                    tooltip: 'X 2',
                    child: Text('x 2')),
                // BlocBuilder + BlocListener = BlocConsumer (will be re-building the UI after the func / event states has changed
                BlocConsumer<CounterTestCubit, CounterTestState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Text(state.totalMultiplyByTwo.toString());
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
