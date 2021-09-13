import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/presentation/movie/list/bloc/movie_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListQueryInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          final inputState = state.queryInput.state;
          final inputValue = state.queryInput.value;

          return TextFormField(
            controller: TextEditingController(text: inputValue)
              ..selection = TextSelection.fromPosition(TextPosition(offset: inputValue.length),
            ),
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              labelText: 'Movie name',
              //helperText: 'A complete, valid movie name e.g. Batman',
              suffixIcon: IconButton(
                onPressed: () => context.read<MovieListBloc>().add(ClearQuery()),
                icon: Icon(Icons.clear),
              ),
              errorText: inputState is InputInvalid ? inputState.error.toString() : null,
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