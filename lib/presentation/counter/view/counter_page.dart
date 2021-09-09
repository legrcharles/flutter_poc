import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(context.read<DataManager>()),
      child: CounterView()
    );
  }
}


class CounterView extends StatefulWidget {
  CounterView({Key? key}) : super(key: key);

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon compteur"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.sync,
              color: Colors.white,
            ),
            label: Text(""),
            onPressed: () => context.read<CounterBloc>().add(Reset()),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Text('${state.value}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterBloc>().add(Increment()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 3,
      ),
    );
  }
}