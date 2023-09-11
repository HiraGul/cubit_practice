import 'package:cubit_practice/UserCubit/user_cubit.dart';
import 'package:cubit_practice/cubit/bool_cubit.dart';
import 'package:cubit_practice/cubit/counter_cubit_cubit.dart';
import 'package:cubit_practice/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<CounterCubitCubit>(
            create: (context) => CounterCubitCubit(initialState: 0)),
        BlocProvider<ChangeStateCubit>(create: (context) => ChangeStateCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UserData(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // incrementCounter(int state) {
  //   BlocProvider.of<CounterCubitCubit>(context).increment(++state);
  // }
  //  decrementCounter(int state) {
  //   BlocProvider.of<CounterCubitCubit>(context).decrement(--state);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubitCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: BlocBuilder<CounterCubitCubit, int>(
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    BlocBuilder<ChangeStateCubit, bool>(
                      builder: (context, boolState) {
                        return Text('$state',
                            style: TextStyle(
                                color: boolState ? Colors.red : Colors.purple));
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<ChangeStateCubit>(context)
                              .changeState(false);
                          BlocProvider.of<CounterCubitCubit>(context)
                              .decrement(--state);
                        },
                        child: Text('decrement'))
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<ChangeStateCubit>(context).changeState(true);
              BlocProvider.of<CounterCubitCubit>(context).increment(++state);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
