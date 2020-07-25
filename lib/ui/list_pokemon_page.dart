import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemongo/ui/detail_pokemon_page.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: Text('Pokemon App'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonHasData) {
            return Center(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.result.length) {
                    return LoadingIndicator();
                  } else {
                    return BlocProvider(
                      create: (context) {
                        return PokemonBloc(apiService: ApiService());
                      },
                      child: PokemonWidget(
                        pokemon: state.result[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 777),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return BlocProvider(
                                  create: (context) {
                                    return PokemonBloc(
                                        apiService: ApiService());
                                  },
                                  child: DetailPokemonPage(
                                    namePokemon: state.result[index].name,
                                    url: state.result[index].url,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
                itemCount: state.hasReachedMax
                    ? state.result.length
                    : state.result.length + 1,
                controller: _scrollController,
              ),
            );
          } else if (state is Error) {
            return Center(child: Text(state.message));
          } else if (state is NoInternetConnection) {
            return Center(child: Text(state.message));
          } else if (state is RequestTimeout) {
            return Center(child: Text(state.message));
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
