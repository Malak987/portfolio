import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Utils/colors.dart';

const LinearGradient kBackgroundGradient = LinearGradient(
  colors: [AppColors.darkNavy, AppColors.navy, AppColors.darkNavy],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

/// Soft radial glow used in section backgrounds (no expensive blur filters).
class GlowOrb extends StatelessWidget {
  final double size;
  final Color color;
  const GlowOrb({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color.withOpacity(0.16), color.withOpacity(0.0)],
            ),
          ),
        ),
      ),
    );
  }
}

/// Frosted glass card wrapper.
class GlassCard extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  const GlassCard({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

/// Standard responsive wrapper for every section of the page.
class SectionShell extends StatelessWidget {
  final double minHeight;
  final EdgeInsets outerPadding;
  final EdgeInsets cardMargin;
  final BorderRadius cardRadius;
  final EdgeInsets cardPadding;
  final List<Widget> background;
  final Widget child;

  const SectionShell({
    super.key,
    required this.minHeight,
    required this.outerPadding,
    required this.cardMargin,
    required this.cardRadius,
    required this.cardPadding,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: minHeight),
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: Stack(
          children: [
            ...background,
            Padding(
              padding: outerPadding,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: cardMargin,
                  child: GlassCard(
                    borderRadius: cardRadius,
                    padding: cardPadding,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Consistent section header: "01." + icon + title + rule line.
class SectionHeader extends StatelessWidget {
  final String number;
  final FaIconData icon;
  final String title;
  final double numberSize;
  final double iconSize;
  final double titleSize;
  final bool center;

  const SectionHeader({
    super.key,
    required this.number,
    required this.icon,
    required this.title,
    required this.numberSize,
    required this.iconSize,
    required this.titleSize,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.accentGradient.createShader(b),
          child: Text(number,
              style: TextStyle(fontSize: numberSize, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 10),
        FaIconBox(icon: icon, size: iconSize),
        SizedBox(width: center ? 12 : 15),
        Text(title,
            style: TextStyle(
                color: AppColors.lightSlate,
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5)),
        if (!center) ...[
          const SizedBox(width: 20),
          const Expanded(child: _HairLine()),
        ],
      ],
    );
  }
}

class FaIconBox extends StatelessWidget {
  final FaIconData icon;
  final double size;
  const FaIconBox({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) => AppColors.accentGradient.createShader(b),
      child: FaIcon(icon, color: Colors.white, size: size),
    );
  }
}

class _HairLine extends StatelessWidget {
  const _HairLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.45),
            Colors.white.withOpacity(0.04),
          ],
        ),
      ),
    );
  }
}
