class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

class R {
  final double w;
  final bool forceMobile;
  R(this.w, {this.forceMobile = false});

  bool get isMobile => forceMobile || w < Breakpoints.mobile;
  bool get isTablet => !isMobile && w < Breakpoints.tablet;
  bool get isWeb => !isMobile && w >= Breakpoints.tablet && w < Breakpoints.desktop;
  bool get isDesktop => !isMobile && w >= Breakpoints.desktop;
}