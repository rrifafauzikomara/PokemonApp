import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class PokemonWidget extends StatefulWidget {
  final Pokemon pokemon;
  final Function onTap;

  const PokemonWidget({Key key, this.pokemon, this.onTap}) : super(key: key);

  @override
  _PokemonWidgetState createState() => _PokemonWidgetState();
}

class _PokemonWidgetState extends State<PokemonWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context)
        .add(LoadPokemonDetail(url: widget.pokemon.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // image
              Container(
                width: Sizes.width(context) / 3,
                height: Sizes.width(context) / 2.5,
                child: BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state) {
                    if (state is PokemonDetailHasData) {
                      return CachedNetworkImage(
                        imageUrl: state.response.sprites.frontDefault,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Sizes.dp10(context)),
                  child: Text(
                    widget.pokemon.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.dp16(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
