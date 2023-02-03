import 'package:assessment_1/bloc/bloc.dart';
import 'package:assessment_1/bloc/pokdex/pokedex_bloc.dart';
import 'package:assessment_1/bloc/pokdex/pokedex_state.dart';
import 'package:assessment_1/views/home.dart';
import 'package:assessment_1/views/login.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Auth/authentication.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authentication = Authentication();
      await authentication.user.first;
      runApp(MyApp(auth: authentication));
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Authentication _auth;

  MyApp({Key? key, required Authentication auth})
      : _auth = auth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _auth,
      child: BlocProvider(
        create: (_) => PokedexBLoC(authentication: _auth),
        child: Pokedex(),
      ),
    );
  }
}

class Pokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0,139,139, 1),
        backgroundColor: Colors.black87,
        hintColor: Colors.grey,
        textTheme: const TextTheme(
          headline5: TextStyle(fontSize: 16, color: Colors.grey),
          headline4: TextStyle(fontSize: 16, color: Color.fromRGBO(0,139,139, 1), fontWeight: FontWeight.w700),
        ),
      ),
      // home: FlowBuilder(
      //   state: context.select((PokedexBLoC bloc) => bloc.state.state),
      //   onGeneratePages: StartupPage,
      // )
      home: BlocBuilder<PokedexBLoC, PokedexState>(
        builder: (context, state) {
          if (state.state == AppStatus.authenticated) {
            // show home page
            return Home();
          }
          // otherwise show login page
          return LoginForm(color: Theme.of(context).primaryColor);
        },
      ),
    );
  }

}
