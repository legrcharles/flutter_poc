import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/presentation/movie/list/movie_list_viewmodel.dart';
import 'package:flutter_architecture/presentation/movie/list/widgets/movie_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListScreen extends ConsumerStatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends ConsumerState<MovieListScreen> {

  late final MovieListViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _viewModel = MovieListViewModel(ref.read(dataManager));

    _searchController = TextEditingController();

    _observeViewData();
  }

  void _observeViewData() {
    _viewModel.searchStream.listen((event) {
      _searchController.text = event;
      _searchController.selection = TextSelection.fromPosition(TextPosition(offset: _searchController.text.length));
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Movies")
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    validator: (value) => value == null || value.isEmpty ? "Enter an movie name" : null,
                    onChanged: (value) {
                      _viewModel.setSearch(value);
                    },
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState?.validate() == true) {
                        _viewModel.loadMovies();
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                    ),

                  ),
                ),
                Expanded(
                    child: StreamBuilder<DataWrapper<List<Movie>>?>(
                      stream: _viewModel.moviesStream,
                      builder: (BuildContext context, AsyncSnapshot<DataWrapper<List<Movie>>?> snapshot) {
                        final state = snapshot.data?.state;
                        if (state != null) {
                          if (state is StateLoading) return Center(child: CircularProgressIndicator());
                          if (state is StateData) return MovieList(movies: state.data ?? []);
                          if (state is StateEmpty) return Center(child: Text('Aucun element'));
                          if (state is StateError) return Center(child: Text('${state.error}'));
                        }
                        return SizedBox.shrink();
                      },
                    )
                )
              ]),
            )
        )

    );
  }
}
