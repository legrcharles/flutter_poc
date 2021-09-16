import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/movie/list/bloc/movie_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MovieListQueryInput extends StatelessWidget {
  const MovieListQueryInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          final inputState = state.queryInput.state;
          final inputValue = state.queryInput.value;

          return PlatformTextField(
            autofocus: true,
            style: TextStyle(color: AppColor.text),
            material: (_, __) => MaterialTextFieldData(
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                labelText: 'Movie name',
                //helperText: 'A complete, valid movie name e.g. Batman',
                suffixIcon: IconButton(
                  onPressed: () =>
                      context.read<MovieListBloc>().add(ClearQuery()),
                  icon: const Icon(Icons.clear),
                ),
                errorText: inputState is InputInvalid
                    ? inputState.error.toString()
                    : null,
              ),
            ),
            cupertino: (_, __) => CupertinoTextFieldData(
                placeholder: "Movie name",
                clearButtonMode: OverlayVisibilityMode.editing,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
                  child: Icon(Icons.search),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.backgroundLight1)),
            controller: TextEditingController(text: inputValue)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: inputValue.length),
              ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              context.read<MovieListBloc>().add(QueryChanged(query: value));
            },
            onSubmitted: (event) {
              context.read<MovieListBloc>().add(FormSubmitted());
            },
            textInputAction: TextInputAction.search,
          );
        },
      ),
    );
  }
}
