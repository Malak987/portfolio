import 'package:flutter/material.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../../Widgets/section_shell.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;
  const AboutSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobileLayout = isMobile || width < 600;
        final isTablet = !isMobileLayout && width >= 600 && width < 1024;
        final isWeb = !isMobileLayout && width >= 1024 && width < 1440;
        final isDesktop = !isMobileLayout && width >= 1440;
        final horizontalLayout = !isMobileLayout && (isWeb || isDesktop);

        final horizontalCardMargin = isMobileLayout ? 12 : (isTablet ? 32 : (isWeb ? 80 : 120));
        final innerPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)), vertical: isMobileLayout ? 40 : (isTablet ? 60 : 80));
        final sectionNumberFontSize = isMobileLayout ? 18 : (isTablet ? 20 : (isWeb ? 22 : 24));
        final headerIconSize = isMobileLayout ? 26 : (isTablet ? 30 : (isWeb ? 32 : 34));
        final titleFontSize = isMobileLayout ? 24 : (isTablet ? 28 : (isWeb ? 30 : 32));
        final bodyFontSize = isMobileLayout ? 13 : (isTablet ? 14 : (isWeb ? 15 : 16));
        final stackTitleFontSize = isMobileLayout ? 15 : (isTablet ? 16 : (isWeb ? 17 : 18));
        final techItemFontSize = isMobileLayout ? 13 : (isTablet ? 14 : (isWeb ? 15 : 16));
        final techItemIconSize = isMobileLayout ? 16 : (isTablet ? 18 : 20);
        final imageSize = isMobileLayout ? 140 : (isTablet ? 190 : (isWeb ? 230 : 260));

        return SectionShell(
          minHeight: 0.9 * screenH,
          outerPadding: const EdgeInsets.symmetric(vertical: 80),
          cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin.toDouble()),
          cardRadius: BorderRadius.circular(isMobileLayout ? 22 : (isTablet ? 24 : 28)),
          cardPadding: innerPadding,
          background: [
            Positioned(bottom: 20, left: -60, child: BlurCircle(size: isMobileLayout ? 190 : (isTablet ? 220 : (isWeb ? 260 : 300)), color: const Color(0xffa855f7))),
            Positioned(top: 20, right: -40, child: BlurCircle(size: isMobileLayout ? 160 : (isTablet ? 200 : (isWeb ? 240 : 280)), color: const Color(0xff22d3ee))),
          ],
          child: horizontalLayout
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: _AboutTextContent(isMobile: false, alignCenter: false, sectionNumberFontSize: sectionNumberFontSize.toDouble(), headerIconSize: headerIconSize.toDouble(), titleFontSize: titleFontSize.toDouble(), bodyFontSize: bodyFontSize.toDouble(), stackTitleFontSize: stackTitleFontSize.toDouble(), techItemFontSize: techItemFontSize.toDouble(), techItemIconSize: techItemIconSize.toDouble())),
                  SizedBox(width: isTablet ? 40 : (isWeb ? 60 : 70)),
                  _ProfileImage(size: imageSize.toDouble(), dpr: dpr),
                ])
              : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  _ProfileImage(size: imageSize.toDouble(), dpr: dpr),
                  const SizedBox(height: 30),
                  _AboutTextContent(isMobile: true, alignCenter: true, sectionNumberFontSize: sectionNumberFontSize.toDouble(), headerIconSize: headerIconSize.toDouble(), titleFontSize: titleFontSize.toDouble(), bodyFontSize: bodyFontSize.toDouble(), stackTitleFontSize: stackTitleFontSize.toDouble(), techItemFontSize: techItemFontSize.toDouble(), techItemIconSize: techItemIconSize.toDouble()),
                ]),
        );
      },
    );
  }
}

class _AboutTextContent extends StatelessWidget {
  final bool isMobile, alignCenter;
  final double sectionNumberFontSize, headerIconSize, titleFontSize, bodyFontSize, stackTitleFontSize, techItemFontSize, techItemIconSize;
  const _AboutTextContent({required this.isMobile, required this.alignCenter, required this.sectionNumberFontSize, required this.headerIconSize, required this.titleFontSize, required this.bodyFontSize, required this.stackTitleFontSize, required this.techItemFontSize, required this.techItemIconSize});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? 480.0 : 560.0),
      child: Column(crossAxisAlignment: alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
          Text('01.', style: TextStyle(color: AppColors.green, fontSize: sectionNumberFontSize, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Icon(Icons.perm_identity_outlined, color: AppColors.green, size: headerIconSize),
          const SizedBox(width: 20),
          Text('About Me', style: TextStyle(color: AppColors.lightSlate, fontSize: titleFontSize, fontWeight: FontWeight.bold)),
          const SizedBox(width: 15),
          Expanded(child: Container(height: 1, color: AppColors.lightNavy)),
          if (!isMobile) Expanded(child: Container(height: 1, color: AppColors.lightNavy)),
        ]),
        const SizedBox(height: 32),
        Text(AppConstants.aboutMe, textAlign: alignCenter ? TextAlign.center : TextAlign.left, style: TextStyle(color: AppColors.slate, fontSize: bodyFontSize, height: 1.7)),
        const SizedBox(height: 20),
        Text("Stack I Use:", style: TextStyle(color: AppColors.lightSlate, fontSize: stackTitleFontSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Wrap(alignment: alignCenter ? WrapAlignment.center : WrapAlignment.start, spacing: isMobile ? 10 : 18, runSpacing: isMobile ? 6 : 10, children: [
          _TechItem('Flutter & Dart', fontSize: techItemFontSize, iconSize: techItemIconSize),
          _TechItem('Figma', fontSize: techItemFontSize, iconSize: techItemIconSize),
          _TechItem('Firebase', fontSize: techItemFontSize, iconSize: techItemIconSize),
          _TechItem('Bloc/Riverpod', fontSize: techItemFontSize, iconSize: techItemIconSize),
          _TechItem('REST API', fontSize: techItemFontSize, iconSize: techItemIconSize),
          _TechItem('Git & GitHub', fontSize: techItemFontSize, iconSize: techItemIconSize),
        ]),
      ]),
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
      width: size, height: size,
      decoration: BoxDecoration(border: Border.all(color: AppColors.lightNavy, width: 1.5), borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset('assets/me/me.jpg', fit: BoxFit.cover, filterQuality: FilterQuality.medium, cacheWidth: (size * dpr).round()),
      ),
    );
  }
}

class _TechItem extends StatelessWidget {
  final String text;
  final double iconSize, fontSize;
  const _TechItem(this.text, {required this.iconSize, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.arrow_right, color: AppColors.green, size: iconSize),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(color: AppColors.slate, fontSize: fontSize)),
    ]);
  }
}