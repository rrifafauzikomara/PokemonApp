import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPokemonPage extends StatefulWidget {
  @override
  _ListPokemonPageState createState() => _ListPokemonPageState();
}

class _ListPokemonPageState extends State<ListPokemonPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(LoadPokemon());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is HasData) {
            return Center(child: Text('Size of Pokemoen --> ${state.response.results.length}'));
          } else if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Error) {
            return Center(child: Text(state.message));
          } else if (state is NoInternetConnection) {
            return Center(child: Text(state.message));
          } else if (state is NoData) {
            return Center(child: Text(state.message));
          } else if (state is RequestTimeout) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(""));
          }
        },
      ),
    );
  }
}
