import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Widgets/section_shell.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;
  const AboutSection({super.key, this.isMobile = false});

  static const List<String> _stack = [
    'Flutter & Dart',
    'Figma',
    'Firebase',
    'Bloc / Cubit',
    'REST API',
    'Git & GitHub',
  ];

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobileLayout = isMobile || width < 600;
        final isTablet = !isMobileLayout && width >= 600 && width < 1024;
        final horizontal = !isMobileLayout && !isTablet;

        final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
        final innerPadding = EdgeInsets.symmetric(
            horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 50),
            vertical: isMobileLayout ? 40 : 70);
        final imageSize = isMobileLayout ? 150.0 : (isTablet ? 200.0 : 250.0);

        return SectionShell(
          minHeight: 0.9 * screenH,
          outerPadding: const EdgeInsets.symmetric(vertical: 80),
          cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
          cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
          cardPadding: innerPadding,
          background: [
            Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 180 : 280, color: AppColors.bronze)),
            Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 160 : 250, color: AppColors.mist)),
          ],
          child: horizontal
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _text(isMobile: false, alignCenter: false, titleSize: 32, bodySize: 15.5)),
                    const SizedBox(width: 60),
                    _ProfileImage(size: imageSize, dpr: dpr),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ProfileImage(size: imageSize, dpr: dpr),
                    const SizedBox(height: 30),
                    _text(isMobile: true, alignCenter: true, titleSize: 24, bodySize: 13.5),
                  ],
                ),
        );
      },
    );
  }

  Widget _text({required bool isMobile, required bool alignCenter, required double titleSize, required double bodySize}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        crossAxisAlignment: alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SectionHeader(
            number: '01.',
            icon: FontAwesomeIcons.user,
            title: 'About Me',
            numberSize: isMobile ? 18 : 22,
            iconSize: isMobile ? 22 : 28,
            titleSize: titleSize,
            center: alignCenter,
          ),
          const SizedBox(height: 28),
          Text(
            AppConstants.aboutMe,
            textAlign: alignCenter ? TextAlign.center : TextAlign.left,
            style: TextStyle(color: AppColors.slate, fontSize: bodySize, height: 1.75),
          ),
          const SizedBox(height: 22),
          Text("Stack I Use:",
              style: TextStyle(
                  color: AppColors.lightSlate,
                  fontSize: isMobile ? 15 : 17,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          Wrap(
            alignment: alignCenter ? WrapAlignment.center : WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: _stack.map((t) => _TechChip(t, isMobile: isMobile)).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final double size;
  final double dpr;
  const _ProfileImage({required this.size, required this.dpr});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.25), blurRadius: 28, offset: const Offset(0, 14))],
      ),
      child: Container(
        decoration: BoxDecoration(color: AppColors.darkNavy, borderRadius: BorderRadius.circular(13)),
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/me/me.jpg',
              fit: BoxFit.cover, filterQuality: FilterQuality.medium, cacheWidth: (size * dpr).round()),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String text;
  final bool isMobile;
  const _TechChip(this.text, {required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 14, vertical: isMobile ? 6 : 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.mist.withOpacity(0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 5, height: 5, decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(
                  color: AppColors.lightSlate,
                  fontSize: isMobile ? 12 : 13.5,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
