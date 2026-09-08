import 'package:flutter/material.dart';
import '../utils/breakpoints.dart';

class HeroSizes {
  final double helloFont;
  final double nameFont;
  final double roleFont;
  final double bodyFont;

  final double contentWidth;
  final double heroHeightFactor;

  final double horizontalCardMargin;
  final EdgeInsets innerPadding;

  final double topHelloSpacing;
  final double afterRolesSpacing;
  final double afterDescriptionSpacing;
  final double afterButtonSpacing;
  final double socialSpacing;

  final double buttonFont;
  final double buttonIcon;
  final EdgeInsets buttonPadding;

  final double socialIcon;

  final bool showRightPanel;

  HeroSizes._({
    required this.helloFont,
    required this.nameFont,
    required this.roleFont,
    required this.bodyFont,
    required this.contentWidth,
    required this.heroHeightFactor,
    required this.horizontalCardMargin,
    required this.innerPadding,
    required this.topHelloSpacing,
    required this.afterRolesSpacing,
    required this.afterDescriptionSpacing,
    required this.afterButtonSpacing,
    required this.socialSpacing,
    required this.buttonFont,
    required this.buttonIcon,
    required this.buttonPadding,
    required this.socialIcon,
    required this.showRightPanel,
  });

  factory HeroSizes.from(R r) {
    final isMobile = r.isMobile;
    final isTablet = r.isTablet;
    final isWeb = r.isWeb;
    final isDesktop = r.isDesktop;

    return HeroSizes._(
      helloFont: isMobile ? 14 : (isTablet ? 16 : (isWeb ? 18 : 20)),
      nameFont: isMobile ? 30 : (isTablet ? 42 : (isWeb ? 56 : 70)),
      roleFont: isMobile ? 22 : (isTablet ? 28 : (isWeb ? 36 : 42)),
      bodyFont: isMobile ? 13 : (isTablet ? 14 : (isWeb ? 16 : 18)),

      contentWidth: isMobile ? 300 : (isTablet ? 450 : (isWeb ? 550 : 600)),
      heroHeightFactor: (isMobile || isTablet) ? 0.9 : 1.0,

      horizontalCardMargin: isMobile ? 12 : (isTablet ? 32 : (isWeb ? 80 : 120)),
      innerPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)),
        vertical: isMobile ? 30 : (isTablet ? 60 : 100),
      ),

      topHelloSpacing: isMobile ? 60 : (isTablet ? 40 : 0),
      afterRolesSpacing: isMobile ? 40 : (isTablet ? 50 : 30),
      afterDescriptionSpacing: isMobile ? 50 : (isTablet ? 60 : 50),
      afterButtonSpacing: isMobile ? 30 : (isTablet ? 50 : 80),
      socialSpacing: isMobile ? 10 : (isTablet ? 14 : 20),

      buttonFont: isMobile ? 13 : (isTablet ? 14 : (isWeb ? 15 : 16)),
      buttonIcon: isMobile ? 14 : (isTablet ? 16 : (isWeb ? 17 : 18)),
      buttonPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 26 : (isWeb ? 30 : 34)),
        vertical: isMobile ? 10 : (isTablet ? 12 : (isWeb ? 14 : 16)),
      ),

      socialIcon: isMobile ? 22 : (isTablet ? 24 : (isWeb ? 26 : 28)),
      showRightPanel: isWeb || isDesktop,
    );
  }
}