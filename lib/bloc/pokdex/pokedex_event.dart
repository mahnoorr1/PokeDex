import 'package:assessment_1/models/user.dart';
import 'package:equatable/equatable.dart';
class PokedexEvent extends Equatable{
  const PokedexEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LogoutRequest extends PokedexEvent{

}

class UserChange extends PokedexEvent{
  final User user;
  const UserChange(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
