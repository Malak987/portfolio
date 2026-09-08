import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Widgets/section_shell.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;
  const ContactSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobileLayout = isMobile || width < 600;
      final isTablet = !isMobileLayout && width >= 600 && width < 1024;
      final isWeb = !isMobileLayout && width >= 1024 && width < 1440;

      final horizontalCardMargin = isMobileLayout ? 12 : (isTablet ? 32 : (isWeb ? 80 : 120));
      final innerPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 20 : (isTablet ? 32 : (isWeb ? 50 : 60)), vertical: isMobileLayout ? 40 : (isTablet ? 60 : 80));
      final smallTitleFontSize = isMobileLayout ? 16 : (isTablet ? 17 : 18);
      final mainTitleFontSize = isMobileLayout ? 28 : (isTablet ? 34 : (isWeb ? 42 : 50));
      final bodyFontSize = isMobileLayout ? 14 : (isTablet ? 16 : 18);
      final footerFontSize = isMobileLayout ? 12 : (isTablet ? 13 : 14);
      final contentWidth = isMobileLayout ? 300 : (isTablet ? 420 : (isWeb ? 520 : 560));
      final buttonPadding = EdgeInsets.symmetric(horizontal: isMobileLayout ? 25 : (isTablet ? 32 : 40), vertical: isMobileLayout ? 12 : (isTablet ? 16 : 20));
      final buttonFontSize = isMobileLayout ? 16 : (isTablet ? 17 : 18);

      return SectionShell(
        minHeight: 0.8 * screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin.toDouble()),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : (isTablet ? 24 : 28)),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: BlurCircle(size: isMobileLayout ? 160 : (isTablet ? 200 : (isWeb ? 240 : 280)), color: const Color(0xff22d3ee))),
          Positioned(bottom: 20, left: -60, child: BlurCircle(size: isMobileLayout ? 190 : (isTablet ? 220 : (isWeb ? 260 : 300)), color: const Color(0xffa855f7))),
        ],
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('05. Communication', style: TextStyle(color: AppColors.green, fontSize: smallTitleFontSize.toDouble())),
          const SizedBox(height: 20),
          Text("Let's Talk !", style: TextStyle(color: AppColors.lightSlate, fontSize: mainTitleFontSize.toDouble(), fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(width: contentWidth.toDouble(), child: Text('Have a project, an idea, or a tech topic you’d like to talk about?\nI’m always open to connecting—feel free to reach out.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.slate, fontSize: bodyFontSize.toDouble(), height: 1.7))),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async { final url = Uri.parse("https://wa.me/201229361950"); if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication); },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, foregroundColor: AppColors.green, side: const BorderSide(color: AppColors.green, width: 2), padding: buttonPadding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
            child: Text('Send Me', style: TextStyle(color: AppColors.green, fontSize: buttonFontSize.toDouble())),
          ),
          const SizedBox(height: 60),
          Text('Built with Flutter 💙', style: TextStyle(color: AppColors.slate, fontSize: footerFontSize.toDouble())),
        ]),
      );
    });
  }
}