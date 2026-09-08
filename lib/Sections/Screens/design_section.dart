import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';
import '../../Widgets/hover_card.dart';

class DesignSection extends StatelessWidget {
  final bool isMobile;
  const DesignSection({super.key, this.isMobile = false});

  final List<Map<String, dynamic>> designs = const [
    {'title': 'Flash App', 'description': 'A complete transportation app design with 30+ screens', 'image': 'assets/project_figma/flash.png', 'tags': ['Mobile Design', 'UI/UX', 'Figma', 'Light & Dark Mode'], 'figmaUrl': 'https://www.figma.com/proto/zCvCeVceJz7jBSvsBNCmyk/Flash?node-id=434-1258&p=f&t=SoKldzIoVs9FShh5-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=434%3A1258', 'behanceUrl': 'https://www.behance.net/gallery/243463775/Flash-App'},
    {'title': 'Bar App', 'description': 'A program for ordering confectionery products via mobile phone', 'image': 'assets/project_figma/bar.png', 'tags': ['Mobile Design', 'UI/UX', 'Figma', 'Light Mode'], 'figmaUrl': 'https://www.figma.com/proto/9UBCirPFsy5cU1aGUCvm9Y/Bar?node-id=68-104&p=f&t=tsFaiqvJdDBA5d4R-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=68%3A104', 'behanceUrl': 'https://www.behance.net/gallery/243415387/Bar-Application'},
    {'title': 'ToneWave Music App', 'description': 'A website for listening to and following trending songs and singers', 'image': 'assets/project_figma/ToneWave.png', 'tags': ['Web Design', 'UI/UX', 'Figma', 'Dark Mode'], 'figmaUrl': 'https://www.figma.com/proto/dsskSb9VZ3iw9BeFswlhMy/ToneWave?node-id=26-5&t=aK0tnt5jPDM5zSEx-1&scaling=contain&content-scaling=fixed&page-id=0%3A1', 'behanceUrl': 'https://www.behance.net/gallery/243743859/TuneWave'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobileLayout = isMobile || width < 600;
      final isTablet = !isMobileLayout && width >= 600 && width < 1024;
      final isWeb = !isMobileLayout && width >= 1024 && width < 1440;
      final centerHeader = isMobileLayout || isTablet;

      final horizontalCardMargin = isMobileLayout ? 12 : (isTablet ? 32 : (isWeb ? 80 : 120));
      final innerPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)), vertical: isMobileLayout ? 40 : (isTablet ? 60 : 80));
      final sectionNumberFontSize = isMobileLayout ? 18 : (isTablet ? 20 : (isWeb ? 22 : 24));
      final iconSize = isMobileLayout ? 26 : (isTablet ? 30 : (isWeb ? 32 : 34));
      final titleFontSize = isMobileLayout ? 24 : (isTablet ? 28 : (isWeb ? 30 : 32));
      final subtitleFontSize = isMobileLayout ? 13 : (isTablet ? 14 : (isWeb ? 15 : 16));
      final betweenSubtitleAndCards = isMobileLayout ? 40.0 : (isTablet ? 50.0 : 60.0);
      final cyanGlowSize = isMobileLayout ? 160.0 : (isTablet ? 200.0 : (isWeb ? 240.0 : 280.0));
      final purpleGlowSize = isMobileLayout ? 190.0 : (isTablet ? 220.0 : (isWeb ? 260.0 : 300.0));
      final cardSpacing = isMobileLayout ? 20.0 : 30.0;

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin.toDouble()),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : (isTablet ? 24 : 28)),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: BlurCircle(size: cyanGlowSize, color: const Color(0xff22d3ee))),
          Positioned(bottom: 20, left: -60, child: BlurCircle(size: purpleGlowSize, color: const Color(0xffa855f7))),
        ],
        child: Column(crossAxisAlignment: centerHeader ? CrossAxisAlignment.center : CrossAxisAlignment.stretch, children: [
          Row(mainAxisAlignment: centerHeader ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
            Text('02.', style: TextStyle(color: AppColors.green, fontSize: sectionNumberFontSize.toDouble(), fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            FaIcon(FontAwesomeIcons.figma, color: AppColors.green, size: iconSize.toDouble()),
            SizedBox(width: isMobileLayout ? 10 : 15),
            Text('My Design', style: TextStyle(color: AppColors.lightSlate, fontSize: titleFontSize.toDouble(), fontWeight: FontWeight.bold)),
            if (!centerHeader) ...[const SizedBox(width: 20), Expanded(child: Container(height: 1, color: AppColors.lightNavy))],
          ]),
          const SizedBox(height: 12),
          Text('From Concept to Design to Code', textAlign: centerHeader ? TextAlign.center : TextAlign.left, style: TextStyle(color: AppColors.slate, fontSize: subtitleFontSize.toDouble())),
          SizedBox(height: betweenSubtitleAndCards),
          Wrap(spacing: cardSpacing, runSpacing: cardSpacing, alignment: WrapAlignment.center, children: designs.map((d) => _DesignCard(design: d, isMobile: isMobileLayout || isTablet)).toList()),
        ]),
      );
    });
  }
}

class _DesignCard extends StatelessWidget {
  final Map<String, dynamic> design;
  final bool isMobile;
  const _DesignCard({required this.design, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cardWidth = isMobile ? MediaQuery.sizeOf(context).width * 0.9 : 400.0;
    final imgHeight = isMobile ? 180.0 : 250.0;

    return HoverCard(
      liftY: 10,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(color: AppColors.lightNavy, borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(10)), child: Image.asset(design['image'], height: imgHeight, width: double.infinity, fit: BoxFit.cover, filterQuality: FilterQuality.medium, cacheWidth: (cardWidth * dpr).round(), errorBuilder: (_, __, ___) => SizedBox(height: imgHeight, child: const Center(child: Icon(Icons.broken_image))))),
          Padding(padding: EdgeInsets.all(isMobile ? 15 : 25), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(design['title'], style: TextStyle(color: AppColors.lightSlate, fontSize: isMobile ? 18 : 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(design['description'], style: TextStyle(color: AppColors.slate, fontSize: isMobile ? 14 : 15, height: 1.5)),
            const SizedBox(height: 20),
            Wrap(spacing: isMobile ? 10 : 15, runSpacing: 8, children: (design['tags'] as List).map((t) => Text(t, style: TextStyle(color: AppColors.slate, fontSize: isMobile ? 12 : 14))).toList()),
            const SizedBox(height: 20),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _GradientMiniButton(onPressed: () => launchUrl(Uri.parse(design['figmaUrl'])), icon: Image.asset("assets/tools/Figma.png", width: 20, height: 20, cacheWidth: (20 * dpr).round()), label: 'My Design', fontSize: isMobile ? 14 : 16, horizontal: isMobile ? 15 : 20, vertical: isMobile ? 10 : 12),
              const SizedBox(width: 20),
              _GradientMiniButton(onPressed: () => launchUrl(Uri.parse(design['behanceUrl'])), icon: FaIcon(FontAwesomeIcons.behance, size: isMobile ? 14 : 16, color: Colors.black), label: 'Open Presentation', fontSize: isMobile ? 12 : 14, horizontal: isMobile ? 15 : 20, vertical: isMobile ? 10 : 12),
            ])),
          ])),
        ]),
      ),
    );
  }
}

class _GradientMiniButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final double fontSize, horizontal, vertical;
  const _GradientMiniButton({required this.onPressed, required this.icon, required this.label, required this.fontSize, required this.horizontal, required this.vertical});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]), borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton.icon(onPressed: onPressed, icon: icon, label: Text(label, style: TextStyle(fontSize: fontSize, color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical))),
    );
  }
}