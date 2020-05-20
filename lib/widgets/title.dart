import 'package:meta/meta.dart';

class Unit {
  final String name;

  const Unit({
    @required this.name,
  })  : assert(name != null);

  Unit.fromJson(Map jsonMap)
      : assert(jsonMap['name'] != null),
        name = jsonMap['name'];
}