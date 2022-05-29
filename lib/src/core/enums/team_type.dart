enum TeamType {
  managment,
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
      case 'managment':
        return TeamType.managment;
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
        return TeamType.managment;
    }
  }
}
