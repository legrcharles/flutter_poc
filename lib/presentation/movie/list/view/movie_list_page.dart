import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/movie/list/bloc/movie_list_bloc.dart';
import 'package:flutter_architecture/presentation/movie/list/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(context.read()),
      child: const MovieListView()
    );
  }
}

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListView> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
            title: const Text(LocaleKeys.movies_title).tr(),
            cupertino: (context, platform) {
              return CupertinoNavigationBarData(
                  transitionBetweenRoutes: true,
                  automaticallyImplyLeading: true,
                  previousPageTitle: LocaleKeys.home_title.tr()
              );
            },
            material: (context, platform) {
              return MaterialAppBarData();
            }
        ),
        body: BlocListener<MovieListBloc, MovieListState>(
          listener: (context, state) {
            final dataState = state.dataState;
/*
            if (dataState is DataStateError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(dataState.error.toString())),
                );
            }

 */
          },
          child: SafeArea(
            bottom: false,
            child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: <Widget>[
                  const MovieListQueryInput(),
                  Expanded(
                      child: BlocBuilder<MovieListBloc, MovieListState>(
                        builder: (context, state) {
                          final inputState = state.queryInput.state;

                          if (Platform.isIOS && inputState is InputInvalid) {
                            return Text(
                              inputState.error.toString(),
                              style: const TextStyle(color: Colors.redAccent));
                          }

                          final dataState = state.dataState;

                          if (dataState is DataStateLoading) {
                            return Center(child: PlatformCircularProgressIndicator());
                          } else if (dataState is DataStateEmpty) {
                            return const Center(child: Text('Aucun film'));
                          } else if (dataState is DataStateError) {
                            return Center(child: Text(dataState.error.toString(), style: TextStyle(color: AppColor.error),));
                          }else if (dataState is DataStateLoaded<List<Movie>>) {
                            return MovieList(movies: dataState.data);
                          }

                          return const MovieList(movies: []);
                        },
                      )
                  )
                ]),
            ),
          ),
        )

    );
  }
}
