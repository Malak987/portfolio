  import 'dart:ui';
  import 'package:flutter/material.dart';

  const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xff020617), Color(0xff020617), Color(0xff0f172a)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  enum ScreenType { mobile, tablet, web, desktop }

  class BaseSection extends StatelessWidget {
    final double heightFactor;
    final EdgeInsets? padding;
    final Widget child;

    const BaseSection({
      super.key,
      this.heightFactor = 1.0,
      this.padding,
      required this.child,
    });

    @override
    Widget build(BuildContext context) {
      return RepaintBoundary(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: heightFactor * MediaQuery.sizeOf(context).height,
          ),
          decoration: const BoxDecoration(gradient: backgroundGradient),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const _BackgroundGlows(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screen = getScreenType(constraints.maxWidth);

                    final horizontalMargin = switch(screen) {
                      ScreenType.mobile => 12.0,
                      ScreenType.tablet => 32.0,
                      ScreenType.web => 80.0,
                      ScreenType.desktop => 120.0,
                    };

                    final innerPadding = switch(screen) {
                      ScreenType.mobile => const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      ScreenType.tablet => const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
                      ScreenType.web => const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
                      ScreenType.desktop => const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
                    };

                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(switch(screen) {
                            ScreenType.mobile => 22,
                            ScreenType.tablet => 24,
                            _ => 28
                          }),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                          boxShadow: const [
                            BoxShadow(color: Colors.black45, blurRadius: 40, offset: Offset(0,24))
                          ],
                        ),
                        child: Padding(
                          padding: padding ?? innerPadding,
                          child: child,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    static ScreenType getScreenType(double width) {
      if(width < 600) return ScreenType.mobile;
      if(width < 1024) return ScreenType.tablet;
      if(width < 1440) return ScreenType.web;
      return ScreenType.desktop;
    }
  }


  class _BackgroundGlows extends StatelessWidget {
    const _BackgroundGlows();

    @override
    Widget build(BuildContext context) {
      return const RepaintBoundary(
        child: Stack(
          children: [
            Positioned(top:20, right: -40, child: _BlurCircle(size: 280, color: Color(0xff22d3ee))),
            Positioned(bottom:20, left: -60, child: _BlurCircle(size: 300, color: Color(0xffa855f7))),
          ],
        ),
      );
    }
  }

  class _BlurCircle extends StatelessWidget {
    final double size;
    final Color color;

    const _BlurCircle({required this.size, required this.color});

    @override
    Widget build(BuildContext context) {
      return IgnorePointer(
        child: RepaintBoundary(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.12),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
    }
  }