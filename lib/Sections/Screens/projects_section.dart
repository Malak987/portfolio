import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';
import '../../Widgets/hover_card.dart';

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  const ProjectsSection({super.key, this.isMobile = false});

  final List<Map<String, dynamic>> projects = const [
    {'title': 'SaveKnee Application', 'description': 'An application for identifying knee osteoarthritis and following up with the patient through the application', 'image': 'assets/flutter_project/logo_save_knee.png', 'tech': ['Flutter', 'Firebase', 'tflite', 'provider', 'url_launcher'], 'githubUrl': 'https://github.com/Malak987/final_save_knee.git', 'YouTube': "https://youtube.com/shorts/5kQtyK72qX4?si=u4_1SV44N88zJRBN"},
    {'title': 'E-Commerce App', 'description': 'A full-featured e-commerce app with products, recipes, cart, wishlist, and user authentication.', 'image': 'assets/flutter_project/e-commerce.png', 'tech': ['Flutter', 'Cubit', 'Hive', 'Dio', 'DummyJSON'], 'githubUrl': 'https://github.com/Malak987/e-commerce-demo-', 'YouTube': "https://youtube.com/shorts/CdqOqDezaRA"},
    {'title': 'Weather Application', 'description': 'A weather app with a great design and animations.', 'image': 'assets/flutter_project/logo_weather_app.png', 'tech': ['Flutter', 'Http', 'Firebase', 'Provider'], 'githubUrl': 'https://github.com/Malak987/Weather.git', 'YouTube': "https://youtube.com/shorts/HmNVkpLDRQM?si=M0w4Vh3lyDZUtaIe"},
    {'title': 'SuperNatural App', 'description': 'A program showcasing the actors participating in the series', 'image': 'assets/flutter_project/supernatural.jpg', 'tech': ['Flutter offline', 'Bloc', 'Cubit', 'chopper', 'http', 'dio'], 'githubUrl': 'https://github.com/Malak987/supernutral.git', 'YouTube': "https://youtube.com/shorts/Wj97ol2q5mA?si=_4t3EjEy6rgcyohV"},
    {'title': 'ToDo App', 'description': 'Daily tasks app with great animation', 'image': 'assets/flutter_project/todo_logo.png', 'tech': ['Flutter', 'Bloc', 'Cubit', 'uuid'], 'githubUrl': 'https://github.com/Malak987/Todo_App.git', 'YouTube': "https://youtube.com/shorts/2rIxyROD_8A?si=WaxTwivHd5DGA9CB"},
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

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : (isWeb ? 80.0 : 120.0));
      final innerPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)), vertical: isMobileLayout ? 40 : (isTablet ? 60 : 80));
      final sectionNumberFontSize = isMobileLayout ? 18.0 : (isTablet ? 20.0 : (isWeb ? 22.0 : 24.0));
      final iconSize = isMobileLayout ? 26.0 : (isTablet ? 30.0 : (isWeb ? 32.0 : 34.0));
      final titleFontSize = isMobileLayout ? 24.0 : (isTablet ? 28.0 : (isWeb ? 30.0 : 32.0));
      final projectsSpacing = isMobileLayout ? 40.0 : (isTablet ? 60.0 : 80.0);

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : (isTablet ? 24 : 28)),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: BlurCircle(size: isMobileLayout ? 160 : (isTablet ? 200 : (isWeb ? 240 : 280)), color: const Color(0xff22d3ee))),
          Positioned(bottom: 20, left: -60, child: BlurCircle(size: isMobileLayout ? 190 : (isTablet ? 220 : (isWeb ? 260 : 300)), color: const Color(0xffa855f7))),
        ],
        child: Column(crossAxisAlignment: centerHeader ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: centerHeader ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
            Text('03.', style: TextStyle(color: AppColors.green, fontSize: sectionNumberFontSize, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            FaIcon(FontAwesomeIcons.flutter, color: AppColors.green, size: iconSize),
            SizedBox(width: isMobileLayout ? 10 : 15),
            Text('My Projects', style: TextStyle(color: AppColors.lightSlate, fontSize: titleFontSize, fontWeight: FontWeight.bold)),
            if (!centerHeader) ...[const SizedBox(width: 20), Expanded(child: Container(height: 1, color: AppColors.lightNavy))],
          ]),
          const SizedBox(height: 40),
          Column(children: List.generate(projects.length, (i) => Padding(padding: EdgeInsets.only(bottom: i == projects.length - 1 ? 0 : projectsSpacing), child: _ProjectCard(project: projects[i], isReversed: !(isMobileLayout || isTablet) && i.isOdd, isMobile: isMobileLayout || isTablet)))),
        ]),
      );
    });
  }
}

class _ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isReversed, isMobile;
  const _ProjectCard({required this.project, this.isReversed = false, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    if (isMobile) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ColorFiltered(colorFilter: ColorFilter.mode(AppColors.white.withOpacity(0.1), BlendMode.srcATop), child: SizedBox(width: double.infinity, height: 200, child: Image.asset(project['image'], fit: BoxFit.cover, filterQuality: FilterQuality.medium, cacheWidth: (MediaQuery.sizeOf(context).width * dpr).round()))),
        const SizedBox(height: 30),
        _content(isMobile: true, dpr: dpr),
      ]);
    }
    return HoverCard(
      liftY: 10,
      child: Stack(children: [
        Align(alignment: isReversed ? Alignment.centerLeft : Alignment.centerRight, child: SizedBox(width: 300, height: 300, child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(project['image'], fit: BoxFit.cover, filterQuality: FilterQuality.medium, cacheWidth: (300 * dpr).round())))),
        Align(alignment: isReversed ? Alignment.centerRight : Alignment.centerLeft, child: _content(isMobile: false, dpr: dpr)),
      ]),
    );
  }

  Widget _content({required bool isMobile, required double dpr}) {
    return Container(
      width: isMobile ? double.infinity : 500,
      padding: EdgeInsets.all(isMobile ? 10 : 30),
      color: isMobile ? AppColors.navy : Colors.transparent,
      child: Column(crossAxisAlignment: isReversed && !isMobile ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
        Text('Featured Project', style: TextStyle(color: AppColors.green, fontSize: isMobile ? 12 : 14)),
        SizedBox(height: isMobile ? 5 : 10),
        Text(project['title'], style: TextStyle(color: AppColors.lightSlate, fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold)),
        SizedBox(height: isMobile ? 10 : 20),
        Container(padding: EdgeInsets.all(isMobile ? 10 : 25), decoration: BoxDecoration(color: AppColors.lightNavy, borderRadius: BorderRadius.circular(5)), child: Text(project['description'], textAlign: isReversed && !isMobile ? TextAlign.right : TextAlign.left, style: TextStyle(color: AppColors.slate, fontSize: isMobile ? 14 : 16, height: 1.5))),
        SizedBox(height: isMobile ? 10 : 20),
        Wrap(spacing: isMobile ? 10 : 15, runSpacing: 8, children: (project['tech'] as List).map((t) => Text(t, style: TextStyle(color: AppColors.slate, fontSize: isMobile ? 12 : 14))).toList()),
        SizedBox(height: isMobile ? 10 : 25),
        Row(mainAxisAlignment: isReversed && !isMobile ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
          if (project['githubUrl'] != null) IconButton(icon: const FaIcon(FontAwesomeIcons.github), color: AppColors.slate, iconSize: isMobile ? 20 : 22, onPressed: () => launchUrl(Uri.parse(project['githubUrl']))),
          if (project['YouTube'] != null) IconButton(icon: const FaIcon(FontAwesomeIcons.youtube), color: AppColors.slate, iconSize: isMobile ? 20 : 22, onPressed: () => launchUrl(Uri.parse(project['YouTube']))),
        ]),
      ]),
    );
  }
}