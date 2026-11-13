import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Widgets/section_shell.dart';
import '../../Widgets/typewriter_text.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  const HeroSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobileLayout = isMobile || width < 600;
        final isTablet = !isMobileLayout && width >= 600 && width < 1024;

        final helloFontSize = isMobileLayout ? 14.0 : (isTablet ? 16.0 : 19.0);
        final nameFontSize = isMobileLayout ? 32.0 : (isTablet ? 44.0 : 62.0);
        final roleFontSize = isMobileLayout ? 21.0 : (isTablet ? 26.0 : 34.0);
        final bodyFontSize = isMobileLayout ? 13.5 : (isTablet ? 14.5 : 16.5);
        final contentWidth = isMobileLayout ? 320.0 : (isTablet ? 450.0 : 560.0);
        final heroHeightFactor = (isMobileLayout || isTablet) ? 0.92 : 1.0;
        final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
        final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 55),
          vertical: isMobileLayout ? 30 : (isTablet ? 60 : 100),
        );
        final socialIconSize = isMobileLayout ? 20.0 : 24.0;
        final showRightPanel = !isMobileLayout && !isTablet;

        return SectionShell(
          minHeight: heroHeightFactor * screenH,
          outerPadding: const EdgeInsets.symmetric(vertical: 80),
          cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
          cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
          cardPadding: EdgeInsets.zero,
          background: [
            Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 180 : 280, color: AppColors.mist)),
            Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 200 : 310, color: AppColors.gold)),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: innerPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobileLayout) const SizedBox(height: 60),
                      Row(
                        children: [
                          Container(width: 34, height: 2, decoration: BoxDecoration(gradient: AppColors.accentGradient, borderRadius: BorderRadius.circular(2))),
                          const SizedBox(width: 10),
                          Text("HELLO, I'M",
                              style: TextStyle(
                                  color: AppColors.slate,
                                  fontSize: helloFontSize,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ShaderMask(
                        shaderCallback: (b) => AppColors.accentGradient.createShader(b),
                        child: Text(AppConstants.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: nameFontSize,
                                fontWeight: FontWeight.w900,
                                height: 1.12,
                                letterSpacing: 0.5)),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: TypewriterText(
                            phrases: [AppConstants.role1, AppConstants.role2, AppConstants.role3],
                            style: TextStyle(
                                color: AppColors.gold,
                                fontSize: roleFontSize,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: contentWidth,
                        child: Text(
                          "I design great UX in Figma and build beautiful Flutter apps for Android, iOS, and Web — from pixel-perfect design to clean, scalable code.",
                          style: TextStyle(
                              color: AppColors.slate.withOpacity(0.95),
                              fontSize: bodyFontSize,
                              height: 1.65),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          _GradientButton(
                            onPressed: () => launchUrl(Uri.parse("https://flowcv.com/resume/w0sjf0chwn"), mode: LaunchMode.externalApplication),
                            icon: FontAwesomeIcons.download,
                            label: "Download Resume",
                            iconSize: isMobileLayout ? 13 : 15,
                            fontSize: isMobileLayout ? 13 : 15,
                          ),
                          _OutlineButton(
                            onPressed: () {
                              final projectsKey = AppSectionTargets.projects;
                              final ctx = projectsKey.currentContext;
                              if (ctx != null) {
                                Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 650), curve: Curves.easeInOutCubic, alignment: -0.06);
                              }
                            },
                            icon: FontAwesomeIcons.eye,
                            label: "View My Work",
                            iconSize: isMobileLayout ? 13 : 15,
                            fontSize: isMobileLayout ? 13 : 15,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Wrap(
                        spacing: isMobileLayout ? 8 : 12,
                        runSpacing: 10,
                        children: [
                          _SocialIcon(icon: FontAwesomeIcons.github, url: AppConstants.github, size: socialIconSize),
                          _SocialIcon(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedin, size: socialIconSize),
                          _SocialIcon(icon: FontAwesomeIcons.figma, url: AppConstants.figma, size: socialIconSize),
                          _SocialIcon(icon: FontAwesomeIcons.behance, url: AppConstants.behance, size: socialIconSize),
                          _SocialIcon(icon: FontAwesomeIcons.instagram, url: AppConstants.instagram, size: socialIconSize),
                          _SocialIcon(icon: FontAwesomeIcons.facebook, url: AppConstants.facebook, size: socialIconSize),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (showRightPanel) const SizedBox(width: 30),
              if (showRightPanel) const _HeroRightSide(),
            ],
          ),
        );
      },
    );
  }
}

/// Simple holder so the hero "View My Work" button can jump to the projects.
class AppSectionTargets {
  static GlobalKey projects = GlobalKey();
}

class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FaIconData icon;
  final String label;
  final double iconSize;
  final double fontSize;
  const _GradientButton({required this.onPressed, required this.icon, required this.label, required this.iconSize, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return _HoverBuilder(builder: (hover) {
      return Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(999),
            boxShadow: hover
                ? [BoxShadow(color: AppColors.gold.withOpacity(0.45), blurRadius: 22, offset: const Offset(0, 10))]
                : [BoxShadow(color: AppColors.mist.withOpacity(0.25), blurRadius: 14, offset: const Offset(0, 6))],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(icon, size: iconSize, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(label, style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _OutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FaIconData icon;
  final String label;
  final double iconSize;
  final double fontSize;
  const _OutlineButton({required this.onPressed, required this.icon, required this.label, required this.iconSize, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return _HoverBuilder(builder: (hover) {
      return Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: hover ? AppColors.gold.withOpacity(0.10) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: hover ? AppColors.gold.withOpacity(0.7) : AppColors.gold.withOpacity(0.45)),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(icon, size: iconSize, color: AppColors.gold),
                  const SizedBox(width: 10),
                  Text(label, style: TextStyle(color: AppColors.lightSlate, fontSize: fontSize, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _HoverBuilder extends StatefulWidget {
  final Widget Function(bool hover) builder;
  const _HoverBuilder({required this.builder});

  @override
  State<_HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<_HoverBuilder> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: widget.builder(_hover),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final double size;
  const _SocialIcon({required this.icon, required this.url, this.size = 24});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.18 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isHovered ? AppColors.accentGradient : null,
            border: Border.all(color: isHovered ? Colors.transparent : Colors.white.withOpacity(0.12)),
            boxShadow: isHovered ? [BoxShadow(color: AppColors.gold.withOpacity(0.45), blurRadius: 16, offset: const Offset(0, 6))] : const [],
          ),
          child: IconButton(
            icon: FaIcon(widget.icon),
            color: isHovered ? Colors.white : AppColors.slate,
            iconSize: widget.size,
            onPressed: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
          ),
        ),
      ),
    );
  }
}

class _HeroRightSide extends StatelessWidget {
  const _HeroRightSide();

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return Padding(
      padding: const EdgeInsets.only(right: 45.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240, height: 270,
            decoration: BoxDecoration(
              color: const Color(0xFF151519),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.gold.withOpacity(0.35), width: 1.2),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 18))],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/tools/flutter.png",
                      height: 190, width: 190,
                      color: Colors.white.withOpacity(0.92),
                      filterQuality: FilterQuality.medium, cacheWidth: (190 * dpr).round()),
                ),
                Positioned(
                  top: 18, left: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.40), borderRadius: BorderRadius.circular(999)),
                    child: const Text("Flutter & UI/UX", style: TextStyle(color: AppColors.lightSlate, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ),
                Positioned(
                  bottom: 18, right: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.14), borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.gold.withOpacity(0.30))),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.star_rounded, size: 15, color: AppColors.gold),
                      SizedBox(width: 6),
                      Text("Full Time", style: TextStyle(color: AppColors.lightSlate, fontSize: 11, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.circle, size: 9, color: AppColors.mint),
              SizedBox(width: 8),
              Text("Available for freelance", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ),
        ],
      ),
    );
  }
}
