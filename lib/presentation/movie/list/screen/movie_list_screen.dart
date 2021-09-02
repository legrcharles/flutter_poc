import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/presentation/movie/list/viewmodel/movie_list_viewmodel.dart';
import 'package:flutter_architecture/presentation/movie/list/widget/movie_list.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {

  final TextEditingController _controller = TextEditingController();
  final viewModel = MovieListViewModel(dataManager);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
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
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    if(value.isNotEmpty) {
                      viewModel.fetchMovies(value);
                      _controller.clear();
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
                  child:  StreamBuilder<DataWrapper<List<Movie>>>(
                    stream: viewModel.moviesStream,
                    builder: (BuildContext context, AsyncSnapshot<DataWrapper<List<Movie>>> snapshot) {
                      final state = snapshot.data?.state ?? DataWrapper.loading();
                      if (snapshot.hasData) {
                        if (state is StateLoading) return Center(child: CircularProgressIndicator());
                        if (state is StateData) return MovieList(movies: state.data ?? []);
                        if (state is StateEmpty) return Center(child: Text('Aucun element'));
                        if (state is StateError) return Center(child: Text('${state.error}'));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ))
            ])
        )

    );
  }
}