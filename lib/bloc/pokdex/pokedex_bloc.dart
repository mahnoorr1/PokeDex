import 'dart:async';
import 'package:assessment_1/Auth/authentication.dart';
import 'package:assessment_1/bloc/pokdex/pokedex_event.dart';
import 'package:assessment_1/bloc/pokdex/pokedex_state.dart';
import 'package:assessment_1/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokedexBLoC extends Bloc<PokedexEvent, PokedexState> {
  final Authentication _auth;
  StreamSubscription<User>? _userSubscription;

  PokedexBLoC({required Authentication authentication})
      : this._auth = authentication,
        super(authentication.currentUser.isNotEmpty
            ? PokedexState.authenticated(authentication.currentUser)
            : PokedexState.unauthenticated()) {
    on<UserChange>(_onUserChange);
    on<LogoutRequest>(_onLogoutRequest);
    _userSubscription = _auth.user.listen((user) => add(UserChange(user)));
  }

  @override
  List<Object?> get props => [];

  void _onUserChange(UserChange event, Emitter<PokedexState> emit) {
    emit(event.user.isNotEmpty
        ? PokedexState.authenticated(event.user)
        : const PokedexState.unauthenticated());
  }

  void _onLogoutRequest(LogoutRequest event, Emitter<PokedexState> emit) {
    unawaited(_auth.logout());
  }
  Future<void> close(){
    _userSubscription?.cancel();
    return super.close();
  }
}
