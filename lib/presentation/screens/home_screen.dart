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
  Widget build(BuildContext homeScreenContext) {
    //ALTERNATIVE OF STREAM --> use LISTENER: base on state update the logic cubit value
    return Scaffold(
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
                listener: (counterCubitListenerContext, state) {
              // TODO: implement listener
              ScaffoldMessenger.of(counterCubitListenerContext).showSnackBar(
                  SnackBar(
                      content: Text(state.wasIncremented == true
                          ? 'Increment'
                          : 'Decrement'),
                      duration: Duration(milliseconds: 500)));
            }, builder: (counterCubitListenerContext, state) {
              return Text('BlocConsumer: ' + state.counterValue.toString());
            }),
            SizedBox(
              height: 24,
            ),

            /// USED WATCH() inside the Builder context !!
            ///when a new state emitted by Bloc / CounterTestCubit / InternetCubit, this watch will be triggered & rebuild UI
            /// builderContext.watch() equals definition of BlocBuilder
            Builder(builder: (context) {
              var counterState = context.watch<CounterTestCubit>().state;

              ///get current [state].
              final internetState = context.watch<InternetCubit>().state;
              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.MOBILE) {
                return Text(
                  'WATCH: Counter ' +
                      counterState.counterValue.toString() +
                      ' Internet: Mobile',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                      ),
                );
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.WIFI) {
                return Text(
                    'WATCH: Counter ' +
                        counterState.counterValue.toString() +
                        ' Internet: Wi-Fi',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black,
                        ));
              } else {
                return Text(
                  'WATCH: Counter ' +
                      counterState.counterValue.toString() +
                      ' Disconnected',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                      ),
                );
              }

              return Text("data");
            }),

            SizedBox(height: 25),

            /// USED SELECT() inside the Builder !!
            /// For SIMPLER field update --> can used select()
            /// For COMPLEX conditions--> can still remain using BlocBuilder & buildWhen()
            Builder(builder: (context) {
              final counterVal = context
                  .select((CounterTestCubit bloc) => bloc.state.counterValue);

              return Text('SELECT: Counter: ' + counterVal.toString());
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    //BlocProvider = what is the user / UI action to a func or event
                    // BlocProvider.of<CounterTestCubit>(context).decrement();
                    // BlocProvider.of<CounterCubit>(context).decrement();
                    ///Updated in Bloc 6.1.0
                    context.read<CounterTestCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} #2'),
                  onPressed: () {
                    //BlocProvider = what is the user / UI action to a func or event
                    // BlocProvider.of<CounterTestCubit>(context).increment();
                    // context.bloc<CounterCubit>().increment(); (deprecated) -> LOCAL ACCESS = this instance of bloc/cubit only in A SINGLE SCREEN)
                    ///Updated in Bloc 6.1.0
                    context.read<CounterTestCubit>().increment();
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
                  Navigator.of(homeScreenContext).pushNamed('/2');
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
                  Navigator.of(homeScreenContext).pushNamed('/3');
                },
                color: Colors.red,
                child: Text('Go to third screen')),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.of(homeScreenContext).pushNamed('/settings');
                },
                color: Colors.red,
                child: Text('Go to Setting screen'))
          ],
        ),
      ),
    );
  }
}
