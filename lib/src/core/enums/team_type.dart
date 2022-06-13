enum TeamType {
  management,
  product,
  design,
  frontend,
  mobile,
  backend,
  cs,
  finance,
  testing,
  lowcode;

  static fromString(String teamType) {
    switch (teamType) {
      case 'management':
        return TeamType.management;
      case 'product':
        return TeamType.product;
      case 'design':
        return TeamType.design;
      case 'frontend':
        return TeamType.frontend;
      case 'mobile':
        return TeamType.mobile;
      case 'backend':
        return TeamType.backend;
      case 'cs':
        return TeamType.cs;
      case 'finance':
        return TeamType.finance;
      case 'testing':
        return TeamType.testing;
      case 'lowcode':
        return TeamType.lowcode;
      default:
        return TeamType.management;
    }
  }

  String get toKey {
    switch (this) {
      case TeamType.management:
        return 'management';
      case TeamType.product:
        return 'product';
      case TeamType.design:
        return 'design';
      case TeamType.frontend:
        return 'frontend';
      case TeamType.mobile:
        return 'mobile';
      case TeamType.backend:
        return 'backend';
      case TeamType.cs:
        return 'cs';
      case TeamType.finance:
        return 'finance';
      case TeamType.testing:
        return 'testing';
      case TeamType.lowcode:
        return 'lowcode';
    }
  }
}
