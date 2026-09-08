import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';

class SkillsSection extends StatelessWidget {
  final bool isMobile;
  const SkillsSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobileLayout = isMobile || width < 600;
      final isTablet = !isMobileLayout && width >= 600 && width < 1024;
      final isWeb = !isMobileLayout && width >= 1024 && width < 1440;
      final verticalLayout = isMobileLayout || isTablet;

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : (isWeb ? 80.0 : 120.0));
      final innerPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)), vertical: isMobileLayout ? 40 : (isTablet ? 60 : 80));
      final sectionNumberFontSize = isMobileLayout ? 18.0 : (isTablet ? 20.0 : (isWeb ? 22.0 : 24.0));
      final iconSize = isMobileLayout ? 26.0 : (isTablet ? 30.0 : (isWeb ? 32.0 : 34.0));
      final titleFontSize = isMobileLayout ? 24.0 : (isTablet ? 28.0 : (isWeb ? 30.0 : 32.0));
      final cyanGlowSize = isMobileLayout ? 160.0 : (isTablet ? 200.0 : (isWeb ? 240.0 : 280.0));
      final purpleGlowSize = isMobileLayout ? 190.0 : (isTablet ? 220.0 : (isWeb ? 260.0 : 300.0));

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : (isTablet ? 24 : 28)),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: BlurCircle(size: cyanGlowSize, color: const Color(0xff22d3ee))),
          Positioned(bottom: 20, left: -60, child: BlurCircle(size: purpleGlowSize, color: const Color(0xffa855f7))),
        ],
        child: Column(crossAxisAlignment: isMobileLayout ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: isMobileLayout ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
            Text('04.', style: TextStyle(color: AppColors.green, fontSize: sectionNumberFontSize, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            FaIcon(FontAwesomeIcons.lightbulb, color: AppColors.green, size: iconSize),
            SizedBox(width: isMobileLayout ? 10 : 20),
            Text('Skills', style: TextStyle(color: AppColors.lightSlate, fontSize: titleFontSize, fontWeight: FontWeight.bold)),
            if (!isMobileLayout) ...[const SizedBox(width: 15), Expanded(child: Container(height: 1, color: AppColors.lightNavy)), Expanded(child: Container(height: 1, color: AppColors.lightNavy))],
          ]),
          const SizedBox(height: 60),
          verticalLayout
              ? const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_SkillCategory(title: '🎨 Design & UI/UX', skills: [{'name': 'Figma', 'level': 0.95}, {'name': 'Adobe XD', 'level': 0.80}, {'name': 'UI/UX Design', 'level': 0.90}, {'name': 'Prototyping', 'level': 0.85}, {'name': 'User Research', 'level': 0.75}], isMobile: true), SizedBox(height: 40), _SkillCategory(title: '💻 Development', skills: [{'name': 'Flutter', 'level': 0.92}, {'name': 'Dart', 'level': 0.90}, {'name': 'Firebase', 'level': 0.85}, {'name': 'REST API', 'level': 0.88}, {'name': 'Git & GitHub', 'level': 0.90}], isMobile: true)])
              : const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: _SkillCategory(title: '🎨 Design & UI/UX', skills: [{'name': 'Figma', 'level': 0.95}, {'name': 'Adobe XD', 'level': 0.80}, {'name': 'UI/UX Design', 'level': 0.90}, {'name': 'Prototyping', 'level': 0.85}, {'name': 'User Research', 'level': 0.75}], isMobile: false)), SizedBox(width: 50), Expanded(child: _SkillCategory(title: '💻 Development', skills: [{'name': 'Flutter', 'level': 0.92}, {'name': 'Dart', 'level': 0.90}, {'name': 'Firebase', 'level': 0.85}, {'name': 'REST API', 'level': 0.88}, {'name': 'Git & GitHub', 'level': 0.90}], isMobile: false))]),
        ]),
      );
    });
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> skills;
  final bool isMobile;
  const _SkillCategory({required this.title, required this.skills, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: Colors.white, fontSize: isMobile ? 20 : 22, fontWeight: FontWeight.bold)),
      SizedBox(height: isMobile ? 20 : 30),
      ...skills.map((skill) {
        final level = (skill['level'] as num).toDouble();
        return Padding(padding: EdgeInsets.only(bottom: isMobile ? 15 : 25), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(skill['name'] as String, style: TextStyle(color: AppColors.lightSlate, fontSize: isMobile ? 14 : 16)), Text('${(level * 100).toInt()}%', style: TextStyle(color: AppColors.lightSlate, fontSize: isMobile ? 12 : 14))]),
          SizedBox(height: isMobile ? 5 : 10),
          ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: level, backgroundColor: AppColors.lightNavy, valueColor: const AlwaysStoppedAnimation(Colors.blueAccent), minHeight: 8)),
        ]));
      }),
    ]);
  }
}