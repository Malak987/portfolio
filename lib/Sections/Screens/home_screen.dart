import 'package:flutter/material.dart';
import '../../Utils/colors.dart';
import 'about_section.dart';
import 'contact_section.dart';
import 'design_section.dart';
import 'hero_section.dart';
import 'projects_section.dart';
import 'skills_section.dart';
import '../../Widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _designKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 🔥 Preload the two most visible images so they paint instantly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      precacheImage(const AssetImage('assets/me/me.jpg'), context);
      precacheImage(const AssetImage('assets/tools/flutter.png'), context);
    });
    // Hero "View my work" button target
    AppSectionTargets.projects = _projectsKey;
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              controller: _scroll,
              physics: const ClampingScrollPhysics(),
              cacheExtent: 600,
              slivers: [
                const SliverToBoxAdapter(child: HeroSection()),
                SliverToBoxAdapter(child: AboutSection(key: _aboutKey)),
                SliverToBoxAdapter(child: DesignSection(key: _designKey)),
                SliverToBoxAdapter(child: ProjectsSection(key: _projectsKey)),
                SliverToBoxAdapter(child: SkillsSection(key: _skillsKey)),
                SliverToBoxAdapter(child: ContactSection(key: _contactKey)),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scroll,
              links: [
                SectionLink('About', _aboutKey),
                SectionLink('Designs', _designKey),
                SectionLink('Projects', _projectsKey),
                SectionLink('Skills', _skillsKey),
                SectionLink('Contact', _contactKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
