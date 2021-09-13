import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/movie/list/bloc/movie_list_bloc.dart';
import 'package:flutter_architecture/presentation/movie/list/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(context.read()),
      child: MovieListView()
    );
  }
}

class MovieListView extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
            title: Text("Movies")
        ),
        body: BlocListener<MovieListBloc, MovieListState>(
          listener: (context, state) {
            final dataState = state.dataState;

            if (dataState is DataStateError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(dataState.error.toString())),
                );
            }
          },
          child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                MovieListQueryInput(),
                Expanded(
                    child: BlocBuilder<MovieListBloc, MovieListState>(
                      builder: (context, state) {
                        final dataState = state.dataState;

                        if (dataState is DataStateLoading) return Center(child: Loading());
                        else if (dataState is DataStateEmpty) return Center(child: Text('Aucun film'));
                        else if (dataState is DataStateLoaded<List<Movie>>) return MovieList(movies: dataState.data);

                        return MovieList(movies: []);
                      },
                    )
                )
              ]),
          ),
        )

    );
  }
}
