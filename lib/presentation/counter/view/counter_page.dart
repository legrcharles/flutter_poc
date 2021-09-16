import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'dart:io' show Platform;

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterBloc(context.read<DataManager>()),
        child: const CounterView());
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> trailingActions = <Widget>[];

    if (Platform.isIOS) {
      trailingActions.add(PlatformIconButton(
        padding: const EdgeInsets.all(4.0),
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          context.read<CounterBloc>().add(Increment());
        },
      ));
    }

    trailingActions.add(PlatformIconButton(
      padding: const EdgeInsets.all(4.0),
      icon: const Icon(
        Icons.sync,
      ),
      onPressed: () {
        //context.read<CounterBloc>().add(Reset());
        Navigator.of(context).pushNamed(Routes.userList.path);
      },
    ));

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text(LocaleKeys.counter_title).tr(),
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
              transitionBetweenRoutes: true,
              automaticallyImplyLeading: true,
              previousPageTitle: LocaleKeys.home_title.tr());
        },
        material: (context, platform) {
          return MaterialAppBarData();
        },
        trailingActions: trailingActions,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.headline2,
                );
              },
            ),
            Container(height: 40),
            PlatformTextButton(
              child: Text("Increment",
                  style: TextStyle(color: AppColor.primary, fontSize: 20)),
              onPressed: () => context.read<CounterBloc>().add(Increment()),
            )
          ],
        ),
      ),
      material: (context, platform) {
        return MaterialScaffoldData(
            floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterBloc>().add(Increment()),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          elevation: 3,
        ));
      },
    );
  }
}
