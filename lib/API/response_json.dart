import 'dart:convert';
import 'package:assessment_1/API/poke_api.dart';
import 'package:assessment_1/models/pokemon.dart';
class Response{
  void getPokemonFromPokeApi() async {
    List<Pokemon> pokemon = [];
    PokeAPI.getPokemon().then((response) {
      List<Map<String, dynamic>> data =
      List.from(json.decode(response.body)['results']);
        pokemon = data.asMap().entries.map<Pokemon>((element) {
          element.value['id'] = element.key + 1;
          element.value['img'] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
          return Pokemon.fromJson(element.value);
        }).toList();
    });
  }
}