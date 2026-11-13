import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';

class _Skill {
  final String name;
  final double level;
  const _Skill(this.name, this.level);
}

const List<_Skill> _designSkills = [
  _Skill('Figma', 0.95),
  _Skill('Adobe XD', 0.80),
  _Skill('UI/UX Design', 0.90),
  _Skill('Prototyping', 0.85),
  _Skill('User Research', 0.75),
];

const List<_Skill> _devSkills = [
  _Skill('Flutter', 0.92),
  _Skill('Dart', 0.90),
  _Skill('Firebase', 0.85),
  _Skill('REST API', 0.88),
  _Skill('Git & GitHub', 0.90),
];

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
      final verticalLayout = isMobileLayout || isTablet;

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
      final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 50),
          vertical: isMobileLayout ? 40 : 70);

      final designCol = _SkillCategory(
        title: 'Design & UI/UX',
        icon: FontAwesomeIcons.palette,
        skills: _designSkills,
        isMobile: isMobileLayout,
      );
      final devCol = _SkillCategory(
        title: 'Development',
        icon: FontAwesomeIcons.code,
        skills: _devSkills,
        isMobile: isMobileLayout,
      );

      return SectionShell(
        minHeight: screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 160 : 250, color: AppColors.gold)),
          Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 180 : 280, color: AppColors.mist)),
        ],
        child: Column(
          crossAxisAlignment: isMobileLayout ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            SectionHeader(
              number: '04.',
              icon: FontAwesomeIcons.bolt,
              title: 'Skills',
              numberSize: isMobileLayout ? 18 : 22,
              iconSize: isMobileLayout ? 22 : 28,
              titleSize: isMobileLayout ? 24 : 32,
              center: isMobileLayout,
            ),
            SizedBox(height: isMobileLayout ? 36 : 56),
            verticalLayout
                ? Column(children: [designCol, SizedBox(height: isMobileLayout ? 36 : 44), devCol])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: designCol),
                      const SizedBox(width: 50),
                      Expanded(child: devCol),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final FaIconData icon;
  final List<_Skill> skills;
  final bool isMobile;
  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.accentGradient.createShader(b),
              child: FaIcon(icon, color: Colors.white, size: isMobile ? 17 : 19),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: TextStyle(
                    color: AppColors.lightSlate,
                    fontSize: isMobile ? 18 : 21,
                    fontWeight: FontWeight.w800)),
          ],
        ),
        SizedBox(height: isMobile ? 18 : 26),
        ...skills.map((skill) {
          return Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 14 : 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(skill.name,
                        style: TextStyle(
                            color: AppColors.lightSlate,
                            fontSize: isMobile ? 14 : 15.5,
                            fontWeight: FontWeight.w500)),
                    Text('${(skill.level * 100).toInt()}%',
                        style: TextStyle(
                            color: AppColors.slate, fontSize: isMobile ? 12 : 13.5)),
                  ],
                ),
                SizedBox(height: isMobile ? 6 : 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 7,
                    child: Stack(
                      children: [
                        Container(color: Colors.white.withOpacity(0.06)),
                        FractionallySizedBox(
                          widthFactor: skill.level,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.accentGradient,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
