import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class ListPokemonPage extends StatefulWidget {
  @override
  _ListPokemonPageState createState() => _ListPokemonPageState();
}

class _ListPokemonPageState extends State<ListPokemonPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PokemonBloc _pokemonBloc;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _pokemonBloc.add(LoadPokemon());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _pokemonBloc = BlocProvider.of<PokemonBloc>(context)..add(LoadPokemon());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is HasData) {
            if (state.result.isEmpty) {
              return Center(
                child: Text('No Pokemon'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.result.length
                    ? BottomLoader()
                    : PokemonWidget(pokemon: state.result[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.result.length
                  : state.result.length + 1,
              controller: _scrollController,
            );
          } else if (state is Error) {
            return Center(child: Text(state.message));
          } else if (state is NoInternetConnection) {
            return Center(child: Text(state.message));
          } else if (state is RequestTimeout) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: Sizes.dp30(context),
          height: Sizes.dp30(context),
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}

class PokemonWidget extends StatelessWidget {

  final Pokemon pokemon;
  const PokemonWidget({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(pokemon.name);
  }
}