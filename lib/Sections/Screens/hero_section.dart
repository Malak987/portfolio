import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Widgets/section_shell.dart';

const LinearGradient _accentGradient = LinearGradient(
  colors: [Color(0xff22d3ee), Color(0xffa855f7)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class HeroSection extends StatefulWidget {
  final bool isMobile;
  const HeroSection({super.key, this.isMobile = false});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final screenH = MediaQuery.sizeOf(context).height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = widget.isMobile || width < 600;
        final isTablet = !isMobile && width >= 600 && width < 1024;
        final isWeb = !isMobile && width >= 1024 && width < 1440;

        final helloFontSize = isMobile ? 14.0 : (isTablet ? 16.0 : (isWeb ? 18.0 : 20.0));
        final nameFontSize = isMobile ? 30.0 : (isTablet ? 42.0 : (isWeb ? 56.0 : 70.0));
        final roleFontSize = isMobile ? 22.0 : (isTablet ? 28.0 : (isWeb ? 36.0 : 42.0));
        final bodyFontSize = isMobile ? 13.0 : (isTablet ? 14.0 : (isWeb ? 16.0 : 18.0));
        final contentWidth = isMobile ? 300.0 : (isTablet ? 450.0 : (isWeb ? 550.0 : 600.0));
        final heroHeightFactor = (isMobile || isTablet) ? 0.9 : 1.0;
        final horizontalCardMargin = isMobile ? 12.0 : (isTablet ? 32.0 : (isWeb ? 80.0 : 120.0));
        final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)),
          vertical: isMobile ? 30 : (isTablet ? 60 : 100),
        );

        final buttonFontSize = isMobile ? 13.0 : (isTablet ? 14.0 : (isWeb ? 15.0 : 16.0));
        final buttonIconSize = isMobile ? 14.0 : (isTablet ? 16.0 : (isWeb ? 17.0 : 18.0));
        final buttonPadding = EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 26 : (isWeb ? 30 : 34)),
          vertical: isMobile ? 10 : (isTablet ? 12 : (isWeb ? 14 : 16)),
        );
        final socialIconSize = isMobile ? 22.0 : (isTablet ? 24.0 : (isWeb ? 26.0 : 28.0));
        final showRightPanel = isWeb || (!isMobile && width >= 1440);

        return SectionShell(
          minHeight: heroHeightFactor * screenH,
          outerPadding: const EdgeInsets.symmetric(vertical: 80),
          cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
          cardRadius: BorderRadius.circular(isMobile ? 22 : (isTablet ? 24 : 28)),
          cardPadding: EdgeInsets.zero,
          background: [
            Positioned(top: 20, right: -40, child: BlurCircle(size: isMobile ? 180 : (isTablet ? 220 : (isWeb ? 260 : 300)), color: const Color(0xff22d3ee))),
            Positioned(bottom: 20, left: -60, child: BlurCircle(size: isMobile ? 200 : (isTablet ? 240 : (isWeb ? 280 : 330)), color: const Color(0xffa855f7))),
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
                      if (isMobile) const SizedBox(height: 40),
                      Text("Hello, I'm", style: TextStyle(color: AppColors.green.withOpacity(0.9), fontSize: helloFontSize, fontWeight: FontWeight.w500, letterSpacing: 1.3)),
                      const SizedBox(height: 20),
                      GradientText(AppConstants.name, gradient: _accentGradient, style: TextStyle(fontSize: nameFontSize, fontWeight: FontWeight.bold, height: 1.1, letterSpacing: 1.2)),
                      const SizedBox(height: 20),
                      RepaintBoundary(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(AppConstants.role1, textStyle: TextStyle(color: const Color(0xff22d3ee), fontSize: roleFontSize, fontWeight: FontWeight.w700), speed: const Duration(milliseconds: 90)),
                              TypewriterAnimatedText(AppConstants.role2, textStyle: TextStyle(color: const Color(0xff22d3ee), fontSize: roleFontSize, fontWeight: FontWeight.w700), speed: const Duration(milliseconds: 90)),
                              TypewriterAnimatedText(AppConstants.role3, textStyle: TextStyle(color: const Color(0xff22d3ee), fontSize: roleFontSize, fontWeight: FontWeight.w700), speed: const Duration(milliseconds: 90)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(width: contentWidth, child: Text("I design great UX in Figma \nand build beautiful Flutter apps for Android, iOS, and Web.", style: TextStyle(color: AppColors.slate.withOpacity(0.9), fontSize: bodyFontSize, height: 1.6))),
                      const SizedBox(height: 40),
                      _GradientButton(onPressed: () async { final url = Uri.parse("https://flowcv.com/resume/w0sjf0chwn"); if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication); }, icon: FontAwesomeIcons.download, label: "Download Resume", iconSize: buttonIconSize, fontSize: buttonFontSize, padding: buttonPadding),
                      const SizedBox(height: 40),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _SocialIcon(icon: FontAwesomeIcons.facebook, url: AppConstants.facebook, size: socialIconSize),
                            SizedBox(width: isMobile ? 10 : 16),
                            _SocialIcon(icon: FontAwesomeIcons.instagram, url: AppConstants.instagram, size: socialIconSize),
                            SizedBox(width: isMobile ? 10 : 16),
                            _SocialIcon(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedin, size: socialIconSize),
                            SizedBox(width: isMobile ? 10 : 16),
                            _SocialIcon(icon: FontAwesomeIcons.figma, url: AppConstants.figma, size: socialIconSize),
                            SizedBox(width: isMobile ? 10 : 16),
                            _SocialIcon(icon: FontAwesomeIcons.github, url: AppConstants.github, size: socialIconSize),
                            SizedBox(width: isMobile ? 10 : 16),
                            _SocialIcon(icon: FontAwesomeIcons.behance, url: AppConstants.behance, size: socialIconSize),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showRightPanel) const SizedBox(width: 40),
              if (showRightPanel) const _HeroRightSide(),
            ],
          ),
        );
      },
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  const GradientText(this.text, {super.key, required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final double iconSize;
  final double fontSize;
  final EdgeInsets padding;
  const _GradientButton({required this.onPressed, required this.icon, required this.label, required this.iconSize, required this.fontSize, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: _accentGradient, borderRadius: BorderRadius.circular(999), boxShadow: [BoxShadow(color: const Color(0xff22d3ee).withOpacity(0.45), blurRadius: 20, offset: const Offset(0, 10))]),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(icon, size: iconSize),
        label: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
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
        scale: isHovered ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: isHovered ? _accentGradient : null, color: isHovered ? null : Colors.transparent, boxShadow: isHovered ? [BoxShadow(color: const Color(0xff22d3ee).withOpacity(0.55), blurRadius: 18, offset: const Offset(0, 8))] : const []),
          child: IconButton(icon: FaIcon(widget.icon), color: isHovered ? Colors.white : AppColors.slate, iconSize: widget.size, onPressed: () async { final uri = Uri.parse(widget.url); if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication); }),
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
      padding: const EdgeInsets.only(right: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 230, height: 260,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0x9922d3ee), Color(0x990ea5e9), Color(0x99a855f7)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(26), boxShadow: [BoxShadow(color: const Color(0xff22d3ee).withOpacity(0.4), blurRadius: 26, offset: const Offset(0, 18))]),
            child: Stack(
              children: [
                Align(alignment: Alignment.center, child: Image.asset("assets/tools/flutter.png", height: 200, width: 200, color: Colors.white.withOpacity(1), filterQuality: FilterQuality.medium, cacheWidth: (200 * dpr).round())),
                Positioned(top: 18, left: 18, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.black.withOpacity(0.28), borderRadius: BorderRadius.circular(999)), child: const Text("Flutter & UI/UX", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)))),
                Positioned(bottom: 18, right: 18, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(999)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star_rounded, size: 16, color: Colors.amber), SizedBox(width: 6), Text("Full Time", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500))]))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withOpacity(0.12))),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.circle, size: 10, color: Colors.lightGreenAccent), SizedBox(width: 8), Text("Available for freelance", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500))]),
          ),
        ],
      ),
    );
  }
}