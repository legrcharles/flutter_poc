import 'package:flutter/material.dart';
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

  final _queryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _queryFocusNode.addListener(() {
      if (!_queryFocusNode.hasFocus) {
        context.read<MovieListBloc>().add(QueryUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _queryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
            title: Text("Movies")
        ),
        body: BlocListener<MovieListBloc, MovieListState>(
          listener: (context, state) {
            if (state.status == FormStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
            }
          },
          child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
                MovieListQueryInput(focusNode: _queryFocusNode),
                Expanded(
                    child: BlocBuilder<MovieListBloc, MovieListState>(
                      builder: (context, state) {
                        if (state.status == FormStatus.loading) return Center(child: Loading());

                        return MovieList(movies: state.movies);
                      },
                    )
                )
              ]),
          ),
        )

    );
  }
}
