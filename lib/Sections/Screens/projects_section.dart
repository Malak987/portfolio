import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> tech;
  final String type;
  final String? githubUrl;
  final String? youtubeUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.image,
    required this.tech,
    required this.type,
    this.githubUrl,
    this.youtubeUrl,
    this.liveUrl,
  });
}

const List<Project> kProjects = [

  Project(
    title: 'Legal Services Platform',
    description:
    'A comprehensive legal services platform featuring a Flutter mobile application and a web admin dashboard. Supports lawyer and client management, bookings, legal service workflows, and secure authentication.',
    image: 'assets/web_projects/Legal Services.png',
    tech: [
      'Flutter',
      'Flutter Web',
      'Supabase',
      'PostgreSQL',
      'BLoC / Cubit',
      'Clean Architecture',
      'RLS',
      'Edge Functions',
    ],
    type: 'Web & Mobile',
    liveUrl: 'https://legal-dashboard-1.web.app/',
  ),

  Project(
    title: 'Bar Web App',
    description:
        'A cakes & bakery web store where customers design their own cake step by step, choose flavors and size, and order anything from the menu with delivery details.',
    image: 'assets/web_projects/bar_web.jpg',
    tech: ['Flutter Web', 'Firebase', 'Custom Cake Builder', 'Orders'],
    type: 'Web App',
    liveUrl: 'https://barwebapp-50930.web.app',
  ),
  Project(
    title: 'Bar Dashboard',
    description:
        'A full admin panel that controls the Bar store: add & configure products, discounts and coupons, manage customization orders, and open/close the custom cake designer.',
    image: 'assets/web_projects/bar_dashboard.jpg',
    tech: ['Flutter Web', 'Firebase', 'Admin Panel', 'Coupons & Discounts'],
    type: 'Web App',
    liveUrl: 'https://bardashboard-e3321.web.app',
  ),

  Project(
    title: 'Heimwerk - Field Service Management',
    description:
    'An offline-first field service management application for kitchen and home renovation businesses. Enables customer and job management, technician assignments, progress tracking, before-and-after photos, and digital customer signatures.',
    image: 'assets/web_projects/heimwerk.png',
    tech: [
      'Flutter',
      'Supabase',
      'PostgreSQL',
      'Drift',
      'BLoC / Cubit',
      'Clean Architecture',
      'Offline-First',
      'GetIt',
    ],
    type: 'Mobile App',
    liveUrl: 'https://heimwerk-1.web.app/',
  ),

  Project(
    title: 'Wedding Invitation',
    description:
        'An elegant private wedding invitation website with a personal photo gallery and a full RSVP system so guests confirm their attendance online.',
    image: 'assets/web_projects/wedding.jpg',
    tech: ['Flutter Web', 'Firebase', 'RSVP System', 'Photo Gallery'],
    type: 'Web App',
    liveUrl: 'https://murad-maria.web.app/',
  ),
  Project(
    title: 'SaveKnee App',
    description:
        'An application for identifying knee osteoarthritis and following up with the patient through the application.',
    image: 'assets/flutter_project/logo_save_knee.png',
    tech: ['Flutter', 'Firebase', 'tflite', 'Provider'],
    type: 'Mobile App',
    githubUrl: 'https://github.com/Malak987/final_save_knee.git',
    youtubeUrl: 'https://youtube.com/shorts/5kQtyK72qX4',
  ),
  Project(
    title: 'E-Commerce App',
    description:
        'A full-featured e-commerce app with products, recipes, cart, wishlist, and user authentication.',
    image: 'assets/flutter_project/e-commerce.png',
    tech: ['Flutter', 'Cubit', 'Hive', 'Dio', 'DummyJSON'],
    type: 'Mobile App',
    githubUrl: 'https://github.com/Malak987/e-commerce-demo-',
    youtubeUrl: 'https://youtube.com/shorts/CdqOqDezaRA',
  ),

];

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  const ProjectsSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobileLayout = isMobile || width < 600;
      final isTablet = !isMobileLayout && width >= 600 && width < 1024;

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
      final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 50),
          vertical: isMobileLayout ? 40 : 70);
      final titleFontSize = isMobileLayout ? 24.0 : (isTablet ? 28.0 : 32.0);

      final int columns = isMobileLayout ? 1 : 2;
      final double spacing = isMobileLayout ? 24 : 32;

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 170 : 260, color: AppColors.mist)),
          Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 190 : 290, color: AppColors.bronze)),
        ],
        child: Column(
          crossAxisAlignment: isMobileLayout ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            SectionHeader(
              number: '03.',
              icon: FontAwesomeIcons.layerGroup,
              title: 'My Projects',
              numberSize: isMobileLayout ? 18 : 22,
              iconSize: isMobileLayout ? 24 : 30,
              titleSize: titleFontSize,
              center: isMobileLayout,
            ),
            const SizedBox(height: 12),
            Text('Flutter apps & full web experiences',
                textAlign: isMobileLayout ? TextAlign.center : TextAlign.left,
                style: TextStyle(color: AppColors.slate, fontSize: isMobileLayout ? 13 : 15)),
            SizedBox(height: isMobileLayout ? 32 : 48),
            LayoutBuilder(builder: (context, c) {
              final cardWidth = (c.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: kProjects
                    .map((p) => _ProjectCard(project: p, width: cardWidth, compact: isMobileLayout))
                    .toList(),
              );
            }),
          ],
        ),
      );
    });
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final double width;
  final bool compact;
  const _ProjectCard({required this.project, required this.width, this.compact = false});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final coverH = widget.compact ? 190.0 : 230.0;

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
            color: _hover ? AppColors.gold.withOpacity(0.55) : Colors.white.withOpacity(0.07),
          ),
          boxShadow: _hover
              ? [BoxShadow(color: AppColors.gold.withOpacity(0.18), blurRadius: 34, offset: const Offset(0, 16))]
              : [BoxShadow(color: Colors.black.withOpacity(0.30), blurRadius: 22, offset: const Offset(0, 12))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Cover ──
              SizedBox(
                height: coverH,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _hover ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      child: Image.asset(
                        p.image,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                        cacheWidth: (widget.width * dpr).round(),
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.navy,
                          child: const Center(child: FaIcon(FontAwesomeIcons.image, color: AppColors.slate)),
                        ),
                      ),
                    ),
                    // bottom fade
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Color(0xAA070B18), Colors.transparent],
                        ),
                      ),
                    ),
                    // type badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xB30A0F20),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              p.type == 'Web App'
                                  ? FontAwesomeIcons.globe
                                  : p.type == 'Web & Mobile'
                                  ? FontAwesomeIcons.layerGroup
                                  : FontAwesomeIcons.mobileScreenButton,
                              size: 10,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 6),
                            Text(p.type,
                                style: const TextStyle(
                                    color: AppColors.lightSlate, fontSize: 11, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    if (p.liveUrl != null)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.mint.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.mint.withOpacity(0.35)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(color: AppColors.mint, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 6),
                              const Text('LIVE',
                                  style: TextStyle(
                                      color: AppColors.mint, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // ── Body ──
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title,
                        style: TextStyle(
                            color: AppColors.lightSlate,
                            fontSize: widget.compact ? 18 : 20,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text(p.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.slate, fontSize: widget.compact ? 13 : 14, height: 1.55)),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: p.tech
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(color: AppColors.gold.withOpacity(0.22)),
                                ),
                                child: Text(t,
                                    style: TextStyle(
                                        color: AppColors.slate,
                                        fontSize: widget.compact ? 11 : 12,
                                        fontWeight: FontWeight.w500)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (p.liveUrl != null) ...[
                          _LiveButton(url: p.liveUrl!, compact: widget.compact),
                          const SizedBox(width: 10),
                        ],
                        const Spacer(),
                        if (p.githubUrl != null)
                          _LinkIcon(
                            icon: FontAwesomeIcons.github,
                            url: p.githubUrl!,
                            hoverColor: AppColors.lightSlate,
                          ),
                        if (p.youtubeUrl != null) ...[
                          const SizedBox(width: 8),
                          _LinkIcon(
                            icon: FontAwesomeIcons.youtube,
                            url: p.youtubeUrl!,
                            hoverColor: const Color(0xFFFF5252),
                          ),
                        ],
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

class _LiveButton extends StatefulWidget {
  final String url;
  final bool compact;
  const _LiveButton({required this.url, this.compact = false});

  @override
  State<_LiveButton> createState() => _LiveButtonState();
}

class _LiveButtonState extends State<_LiveButton> {
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
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(999),
            boxShadow: _hover
                ? [BoxShadow(color: AppColors.gold.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))]
                : const [],
          ),
          child: InkWell(
            onTap: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.compact ? 14 : 16, vertical: widget.compact ? 8 : 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 11, color: Colors.white),
                  const SizedBox(width: 7),
                  Text('Live Demo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.compact ? 12 : 13,
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

class _LinkIcon extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final Color hoverColor;
  const _LinkIcon({required this.icon, required this.url, required this.hoverColor});

  @override
  State<_LinkIcon> createState() => _LinkIconState();
}

class _LinkIconState extends State<_LinkIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.icon == FontAwesomeIcons.github ? 'GitHub' : 'YouTube demo',
      waitDuration: const Duration(milliseconds: 400),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: FaIcon(widget.icon,
                size: 18, color: _hover ? widget.hoverColor : AppColors.slate),
          ),
        ),
      ),
    );
  }
}
