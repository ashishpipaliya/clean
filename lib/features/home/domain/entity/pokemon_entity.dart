class PokemonEntity {
  final String name;
  final String url;

  PokemonEntity({
    required this.name,
    required this.url,
  });

  int get id {
    final segments = url.split('/');
    return int.parse(segments[segments.length - 2]);
  }
}
