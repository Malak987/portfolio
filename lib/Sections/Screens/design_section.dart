import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';

class DesignItem {
  final String title;
  final String description;
  final String image;
  final List<String> tags;
  final String figmaUrl;
  final String behanceUrl;
  const DesignItem({
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    required this.figmaUrl,
    required this.behanceUrl,
  });
}

const List<DesignItem> kDesigns = [
  DesignItem(
    title: 'Flash App',
    description: 'A complete transportation app design with 30+ screens',
    image: 'assets/project_figma/flash.png',
    tags: ['Mobile Design', 'UI/UX', 'Figma', 'Light & Dark Mode'],
    figmaUrl: 'https://www.figma.com/proto/zCvCeVceJz7jBSvsBNCmyk/Flash?node-id=434-1258&p=f&t=SoKldzIoVs9FShh5-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=434%3A1258',
    behanceUrl: 'https://www.behance.net/gallery/243463775/Flash-App',
  ),
  DesignItem(
    title: 'Bar App',
    description: 'A program for ordering confectionery products via mobile phone',
    image: 'assets/project_figma/bar.png',
    tags: ['Mobile Design', 'UI/UX', 'Figma', 'Light Mode'],
    figmaUrl: 'https://www.figma.com/proto/9UBCirPFsy5cU1aGUCvm9Y/Bar?node-id=68-104&p=f&t=tsFaiqvJdDBA5d4R-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=68%3A104',
    behanceUrl: 'https://www.behance.net/gallery/243415387/Bar-Application',
  ),
  DesignItem(
    title: 'ToneWave Music App',
    description: 'A website for listening to and following trending songs and singers',
    image: 'assets/project_figma/ToneWave.png',
    tags: ['Web Design', 'UI/UX', 'Figma', 'Dark Mode'],
    figmaUrl: 'https://www.figma.com/proto/dsskSb9VZ3iw9BeFswlhMy/ToneWave?node-id=26-5&t=aK0tnt5jPDM5zSEx-1&scaling=contain&content-scaling=fixed&page-id=0%3A1',
    behanceUrl: 'https://www.behance.net/gallery/243743859/TuneWave',
  ),
];

class DesignSection extends StatelessWidget {
  final bool isMobile;
  const DesignSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobileLayout = isMobile || width < 600;
      final isTablet = !isMobileLayout && width >= 600 && width < 1024;
      final centerHeader = isMobileLayout || isTablet;

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
      final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 50),
          vertical: isMobileLayout ? 40 : 70);
      final cardWidth = isMobileLayout
          ? MediaQuery.sizeOf(context).width * 0.85
          : (isTablet ? (width - 64 - 100 - 30) / 2 : 400.0);

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 160 : 250, color: AppColors.mist)),
          Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 180 : 280, color: AppColors.gold)),
        ],
        child: Column(
          crossAxisAlignment: centerHeader ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          children: [
            SectionHeader(
              number: '02.',
              icon: FontAwesomeIcons.penNib,
              title: 'My Design',
              numberSize: isMobileLayout ? 18 : 22,
              iconSize: isMobileLayout ? 22 : 28,
              titleSize: isMobileLayout ? 24 : 32,
              center: centerHeader,
            ),
            const SizedBox(height: 12),
            Text('From Concept to Design to Code',
                textAlign: centerHeader ? TextAlign.center : TextAlign.left,
                style: TextStyle(color: AppColors.slate, fontSize: isMobileLayout ? 13 : 15)),
            SizedBox(height: isMobileLayout ? 32 : 48),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: kDesigns
                  .map((d) => _DesignCard(design: d, width: cardWidth, isMobile: isMobileLayout))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}

class _DesignCard extends StatefulWidget {
  final DesignItem design;
  final double width;
  final bool isMobile;
  const _DesignCard({required this.design, required this.width, this.isMobile = false});

  @override
  State<_DesignCard> createState() => _DesignCardState();
}

class _DesignCardState extends State<_DesignCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final d = widget.design;
    final imgHeight = widget.isMobile ? 180.0 : 240.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: widget.width,
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.lightNavy.withOpacity(0.85),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: _hover ? AppColors.mist.withOpacity(0.55) : Colors.white.withOpacity(0.07)),
          boxShadow: _hover
              ? [BoxShadow(color: AppColors.mist.withOpacity(0.18), blurRadius: 34, offset: const Offset(0, 16))]
              : [BoxShadow(color: Colors.black.withOpacity(0.30), blurRadius: 22, offset: const Offset(0, 12))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: SizedBox(
                  height: imgHeight,
                  width: double.infinity,
                  child: Image.asset(
                    d.image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    cacheWidth: (widget.width * dpr).round(),
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.navy,
                      child: const Center(child: FaIcon(FontAwesomeIcons.image, color: AppColors.slate)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(widget.isMobile ? 15 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d.title,
                        style: TextStyle(
                            color: AppColors.lightSlate,
                            fontSize: widget.isMobile ? 18 : 21,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text(d.description,
                        style: TextStyle(
                            color: AppColors.slate, fontSize: widget.isMobile ? 13 : 14, height: 1.5)),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: d.tags
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.mist.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(color: AppColors.mist.withOpacity(0.22)),
                                ),
                                child: Text(t,
                                    style: TextStyle(
                                        color: AppColors.slate,
                                        fontSize: widget.isMobile ? 11 : 12,
                                        fontWeight: FontWeight.w500)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _MiniButton(
                          onPressed: () => launchUrl(Uri.parse(d.figmaUrl), mode: LaunchMode.externalApplication),
                          icon: const FaIcon(FontAwesomeIcons.figma, size: 13, color: Colors.white),
                          label: 'Figma Design',
                          fontSize: widget.isMobile ? 12 : 13,
                        ),
                        _MiniButton(
                          onPressed: () => launchUrl(Uri.parse(d.behanceUrl), mode: LaunchMode.externalApplication),
                          icon: const FaIcon(FontAwesomeIcons.behance, size: 13, color: Colors.white),
                          label: 'Presentation',
                          fontSize: widget.isMobile ? 12 : 13,
                          outline: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final double fontSize;
  final bool outline;
  const _MiniButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.fontSize,
    this.outline = false,
  });

  @override
  State<_MiniButton> createState() => _MiniButtonState();
}

class _MiniButtonState extends State<_MiniButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: widget.outline || _hover ? null : AppColors.accentGradient,
            color: widget.outline
                ? (_hover ? AppColors.gold.withOpacity(0.10) : Colors.transparent)
                : null,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
                color: widget.outline
                    ? (_hover ? AppColors.gold.withOpacity(0.7) : AppColors.gold.withOpacity(0.45))
                    : Colors.transparent),
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon,
                  const SizedBox(width: 8),
                  Text(widget.label,
                      style: TextStyle(
                          color: widget.outline ? AppColors.lightSlate : Colors.white,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
