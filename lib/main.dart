import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemongo/ui/list_pokemon_page.dart';
import 'package:shared/shared.dart';

void main() async {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = MovieBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorPalettes.lightPrimary,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightTheme,
      home: BlocProvider(
        create: (context) {
          return PokemonBloc(apiService: ApiService());
        },
        child: ListPokemonPage(),
      ),
    );
  }
}
