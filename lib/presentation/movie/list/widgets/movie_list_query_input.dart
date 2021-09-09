import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/movie/list/bloc/movie_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListQueryInput extends StatelessWidget {
  MovieListQueryInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          return TextFormField(
            controller: TextEditingController(text: state.query)
              ..selection = TextSelection.fromPosition(TextPosition(offset: state.query.length),
            ),
            focusNode: focusNode,
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              labelText: 'Movie name',
              //helperText: 'A complete, valid movie name e.g. Batman',
              suffixIcon: IconButton(
                onPressed: () => context.read<MovieListBloc>().add(ClearQuery()),
                icon: Icon(Icons.clear),
              ),
              errorText: !state.isQueryValid
                  ? 'Please ensure the movie name entered is valid'
                  : null,

            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              context.read<MovieListBloc>().add(QueryChanged(query: value));
            },
            onFieldSubmitted: (event) {
              context.read<MovieListBloc>().add(FormSubmitted());
            },
            textInputAction: TextInputAction.search,
          );
        },
      ),
    );
  }
}