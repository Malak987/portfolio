import 'package:flutter/material.dart';
import '../../Utils/responsive_layout.dart';
import 'about_section.dart';
import 'contact_section.dart';
import 'design_section.dart';
import 'hero_section.dart';
import 'projects_section.dart';
import 'skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 🔥 Preload critical images to prevent Layout Shift & speed up FCP
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/me/me.jpg'), context);
      precacheImage(const AssetImage('assets/tools/flutter.png'), context);
      precacheImage(const AssetImage('assets/project_figma/flash.png'), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildScrollView(isMobile: true),
        tablet: _buildScrollView(isMobile: false),
        desktop: _buildScrollView(isMobile: false),
      ),
    );
  }

  Widget _buildScrollView({required bool isMobile}) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      cacheExtent: 900, // Keeps off-screen sections ready
      slivers: [
        SliverToBoxAdapter(child: HeroSection(isMobile: isMobile)),
        SliverToBoxAdapter(child: AboutSection(isMobile: isMobile)),
        SliverToBoxAdapter(child: DesignSection(isMobile: isMobile)),
        SliverToBoxAdapter(child: ProjectsSection(isMobile: isMobile)),
        SliverToBoxAdapter(child: SkillsSection(isMobile: isMobile)),
        SliverToBoxAdapter(child: ContactSection(isMobile: isMobile)),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}