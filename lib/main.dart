import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_p/cubit/counter_cubit.dart';
import 'package:flutter_bloc_p/cubit/counter_cubit_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>CounterCubit()),
    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final counterState = context.read<CounterCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<CounterCubit,CounterCubitState>(
        builder: (context,state){
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                FloatingActionButton(onPressed: (){
                  counterState.counterDecrease();
                },
                  child: const Text("-"),
                ),

                (state is CounterValueUpdate) ? Text(state.counter.toString(),style: const TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600
                ),) : const Text("0",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600
                ),),

                FloatingActionButton(onPressed: (){
                  counterState.counterIncrease();
                },
                  child: const Text("+"),
                ),

              ],
            ),
          );
        },
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
