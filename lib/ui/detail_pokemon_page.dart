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
        elevation: 0,
        title: Text(widget.namePokemon),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonDetailHasData) {
            return Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                CachedNetworkImage(
                  width: Sizes.width(context),
                  height: Sizes.width(context) / 2,
                  fit: BoxFit.contain,
                  imageUrl: state.response.sprites.frontDefault,
                  placeholder: (context, url) => LoadingIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.width(context) / 2),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalettes.lightAccent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Sizes.dp30(context)),
                        topLeft: Radius.circular(Sizes.dp30(context)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: Sizes.dp20(context),
                                bottom: Sizes.dp20(context)),
                            child: Text(
                              state.response.name,
                              style: TextStyle(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.dp22(context),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Detail :",
                              style: TextStyle(
                                fontSize: Sizes.dp15(context),
                                fontWeight: FontWeight.bold,
                                color: ColorPalettes.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Sizes.dp10(context)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Weight : ${state.response.weight}, Height : ${state.response.height}',
                              style: TextStyle(
                                color: ColorPalettes.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Experience : ${state.response.baseExperience} XP',
                              style: TextStyle(
                                color: ColorPalettes.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Sizes.dp10(context)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Types :",
                              style: TextStyle(
                                fontSize: Sizes.dp15(context),
                                fontWeight: FontWeight.bold,
                                color: ColorPalettes.white,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              for (int i = 0;
                                  i < state.response.types.length;
                                  i++)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10, top: 10),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      state.response.types[i].type.name,
                                      style: TextStyle(
                                        color: ColorPalettes.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorPalettes.red,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
