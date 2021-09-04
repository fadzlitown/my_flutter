import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/const/enums.dart';
import 'package:flutter_practices/logic/cubit_test/counter_test_cubit.dart';
import 'package:flutter_practices/logic/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.total, this.color}) : super(key: key);

  final String title;
  final String total;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //ALTERNATIVE OF STREAM --> use LISTENER: base on state update the logic cubit value
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.WIFI) {
          BlocProvider.of<CounterTestCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.MOBILE) {
          BlocProvider.of<CounterTestCubit>(context).decrement();
        } else if (state is InternetDisconnected) {}
      },
      child: Scaffold(
        appBar: AppBar(
          // To access HomeScreen variable, needs to use widget.variableName
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //update the UI state
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.WIFI) {
                  return Text('Wi-Fi',
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.green,
                          ));
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.MOBILE) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.red,
                        ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.grey,
                        ),
                  );
                }
                return CircularProgressIndicator();
              }),
              //only wrap the intent widget only !! NOT THE WHOLE BODY / Column
              // BlocBuilder + BlocListener = BlocConsumer (will be re-building the UI after the func / event states has changed
              BlocConsumer<CounterTestCubit, CounterTestState>(
                  listener: (context, state) {
                // TODO: implement listener
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.wasIncremented == true
                        ? 'Increment'
                        : 'Decrement'),
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
                      // context.bloc<CounterCubit>().increment(); (deprecated) -> LOCAL ACCESS = this instance of bloc/cubit only in A SINGLE SCREEN)
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
                  onPressed: () {
                    //note 1: below is an ANONYMOUS ROUTING w/o a name
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (newContext) {
                    //   return SecondScreen(title: 'Second Screen', colorApp: Colors.blueGrey,);}));

                    //note 2: below is an NAMED ROUTING
                    Navigator.of(context).pushNamed('/2');
                  },
                  color: Colors.red,
                  child: Text('Go to second screen')),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  onPressed: () {
                    //note 1: below is an ANONYMOUS ROUTING w/o a name
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (newContext) {
                    //   return SecondScreen(title: 'Second Screen', colorApp: Colors.blueGrey,);}));

                    //note 2: below is an NAMED ROUTING
                    Navigator.of(context).pushNamed('/3');
                  },
                  color: Colors.red,
                  child: Text('Go to third screen'))
            ],
          ),
        ),
      ),
    );
  }
}
