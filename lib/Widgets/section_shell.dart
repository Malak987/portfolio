import 'package:flutter/material.dart';

const LinearGradient kBackgroundGradient = LinearGradient(
  colors: [Color(0xff020617), Color(0xff020617), Color(0xff0f172a)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class BlurCircle extends StatelessWidget {
  final double size;
  final Color color;
  const BlurCircle({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.30), color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}

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
        color: Colors.white.withOpacity(0.04),
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

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