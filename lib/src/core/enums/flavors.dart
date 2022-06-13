enum Flavor {
  dev,
  qa,
  prod;

  static Flavor? fromString(String? flavor) {
    switch (flavor) {
      case 'dev':
        return Flavor.dev;
      case 'qa':
        return Flavor.qa;
      case 'prod':
        return Flavor.prod;
      default:
        return null;
    }
  }

  String get toKey {
    switch (this) {
      case Flavor.dev:
        return 'dev';
      case Flavor.qa:
        return 'qa';
      case Flavor.prod:
        return 'prod';
    }
  }
}
