import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({Key key, this.title, this.total, this.colorApp})
      : super(key: key);

  final String title;
  final String total;
  final Color colorApp;

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {

  _ThirdScreenState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorApp,
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
            SizedBox(
              height: 30,
            ),
            MaterialButton(
                onPressed: () {},
                color: Colors.red,
                child: Text('NOTHING'))
          ],
        ),
      ),
    );
  }
}
