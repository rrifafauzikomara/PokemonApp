import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DetailPokemonPage extends StatefulWidget {
  final String namePokemon, url;

  const DetailPokemonPage(
      {Key key, @required this.namePokemon, @required this.url})
      : super(key: key);

  @override
  _DetailPokemonPageState createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context)
        .add(LoadPokemonDetail(url: widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namePokemon),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonDetailHasData) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: Sizes.width(context),
                      height: Sizes.width(context) / 2,
                      child: CachedNetworkImage(
                        imageUrl: state.response.sprites.frontDefault,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(state.response.name),
                    ),
                    SizedBox(height: Sizes.dp10(context)),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Detail :",
                          ),
                        ),
                        SizedBox(height: Sizes.dp10(context)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Height: ${state.response.height}, Width: ${state.response.weight}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
