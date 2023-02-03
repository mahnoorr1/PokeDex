import 'package:assessment_1/models/user.dart';
import 'package:equatable/equatable.dart';

enum AppStatus{authenticated, unauthenticated}
class PokedexState extends Equatable{
  final AppStatus state;
  final User user;
  const PokedexState._({
    required this.state,
    this.user = User.empty,
  });

  const PokedexState.authenticated(User user): this._(state: AppStatus.authenticated, user: user);
  const PokedexState.unauthenticated(): this._(state: AppStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object?> get props => [state, user];



}
