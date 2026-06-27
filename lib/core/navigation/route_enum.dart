enum RouteEnum {
  entry('/'),
  home('/home'),
  product('/product');

  const RouteEnum(this.path);

  /// The Navigator path string for this route.
  final String path;

  /// Looks up the matching [RouteEnum] for a given string path.
  static RouteEnum? fromPath(String? path) {
    for (final value in RouteEnum.values) {
      if (value.path == path) return value;
    }
    return null; // Returns null if no match is found
  }
}
