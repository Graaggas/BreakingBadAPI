import 'package:breaking_bad_api/bloc_characters/characters_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersBloc>(context).add(CharactersRequestedEvent());

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
          if (state is CharactersInitialState) {
            return Text(
              "initial",
              style: TextStyle(fontSize: 33, color: Colors.white),
            );
          }
          if (state is CharactersLoadInProgressState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CharactersLoadFailureState) {
            return Text(
              "Load is failured",
              style: TextStyle(fontSize: 33, color: Colors.white),
            );
          }
          if (state is CharactersLoadSuccessState) {
            final listOfChars = state.characters.characters;
            return Text(
              listOfChars[25].name,
              style: TextStyle(fontSize: 33, color: Colors.white),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
