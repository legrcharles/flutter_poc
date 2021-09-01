import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/counter/viewmodel/counter_viewmodel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterScreen extends StatefulHookWidget {
  CounterScreen({Key? key, required this.title, required this.initialValue}) : super(key: key);

  final String title;
  final int initialValue;

  @override
  _CounterScreenState createState() => _CounterScreenState(initialValue);
}

class _CounterScreenState extends State<CounterScreen> {

  final _viewModel = CounterViewModel();
  int _initialValue = 0;

  _CounterScreenState(this._initialValue): super();

  @override
  void initState() {
    super.initState();
    _viewModel.initCounter(_initialValue);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

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
            StreamBuilder(
                stream: _viewModel.steamCounter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text('${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.onIncrementButtonTapped,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 3,
      ),
    );
  }
}