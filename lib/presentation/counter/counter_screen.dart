import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/counter/counter_viewmodel.dart';

class CounterScreen extends StatefulWidget {
  final String title;
  final int initialValue;

  CounterScreen({Key? key, required this.title, this.initialValue = 0}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState(initialValue: initialValue);
}

class _CounterScreenState extends State<CounterScreen> {

  final CounterViewModel _viewModel;

  _CounterScreenState({int initialValue = 0}):
    _viewModel = CounterViewModel(initialCount: initialValue);

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
                stream: _viewModel.counterStream,
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