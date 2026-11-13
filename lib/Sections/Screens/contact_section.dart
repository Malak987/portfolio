import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
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

      final horizontalCardMargin = isMobileLayout ? 12.0 : (isTablet ? 32.0 : 80.0);
      final innerPadding = EdgeInsets.symmetric(
          horizontal: isMobileLayout ? 20 : (isTablet ? 32 : 50),
          vertical: isMobileLayout ? 40 : 70);
      final mainTitleFontSize = isMobileLayout ? 30.0 : (isTablet ? 36.0 : 48.0);

      return SectionShell(
        minHeight: 0.8 * screenH,
        outerPadding: const EdgeInsets.symmetric(vertical: 80),
        cardMargin: EdgeInsets.symmetric(horizontal: horizontalCardMargin),
        cardRadius: BorderRadius.circular(isMobileLayout ? 22 : 28),
        cardPadding: innerPadding,
        background: [
          Positioned(top: 20, right: -40, child: GlowOrb(size: isMobileLayout ? 160 : 250, color: AppColors.bronze)),
          Positioned(bottom: 20, left: -60, child: GlowOrb(size: isMobileLayout ? 180 : 280, color: AppColors.mist)),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 26, height: 2, decoration: BoxDecoration(gradient: AppColors.accentGradient, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 10),
                Text('05. LET\'S CONNECT',
                    style: TextStyle(
                        color: AppColors.slate,
                        fontSize: isMobileLayout ? 13 : 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3)),
                const SizedBox(width: 10),
                Container(width: 26, height: 2, decoration: BoxDecoration(gradient: AppColors.accentGradient, borderRadius: BorderRadius.circular(2))),
              ],
            ),
            const SizedBox(height: 18),
            ShaderMask(
              shaderCallback: (b) => AppColors.accentGradient.createShader(b),
              child: Text("Let's Talk!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: mainTitleFontSize,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'Have a project, an idea, or a tech topic you’d like to talk about?\nI’m always open to connecting—feel free to reach out.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.slate,
                    fontSize: isMobileLayout ? 14 : 16.5,
                    height: 1.7),
              ),
            ),
            const SizedBox(height: 34),
            _TalkButton(isMobile: isMobileLayout),
            const SizedBox(height: 36),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isMobileLayout ? 6 : 10,
              runSpacing: 8,
              children: [
                _FooterLink(icon: FontAwesomeIcons.envelope, url: 'mailto:${AppConstants.email}', tooltip: AppConstants.email),
                _FooterLink(icon: FontAwesomeIcons.whatsapp, url: AppConstants.phone, tooltip: 'WhatsApp'),
                _FooterLink(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedin, tooltip: 'LinkedIn'),
                _FooterLink(icon: FontAwesomeIcons.github, url: AppConstants.github, tooltip: 'GitHub'),
                _FooterLink(icon: FontAwesomeIcons.instagram, url: AppConstants.instagram, tooltip: 'Instagram'),
              ],
            ),
            const SizedBox(height: 34),
            Text('Built with Flutter 💙',
                style: TextStyle(
                    color: AppColors.slate.withOpacity(0.75),
                    fontSize: isMobileLayout ? 12 : 13.5)),
          ],
        ),
      );
    });
  }
}

class _TalkButton extends StatefulWidget {
  final bool isMobile;
  const _TalkButton({required this.isMobile});

  @override
  State<_TalkButton> createState() => _TalkButtonState();
}

class _TalkButtonState extends State<_TalkButton> {
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
            color: _hover ? AppColors.mint.withOpacity(0.10) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _hover ? AppColors.mint : AppColors.mint.withOpacity(0.6), width: 1.6),
          ),
          child: InkWell(
            onTap: () => launchUrl(Uri.parse(AppConstants.phone), mode: LaunchMode.externalApplication),
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 30 : 40, vertical: widget.isMobile ? 13 : 17),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.whatsapp, size: widget.isMobile ? 17 : 19, color: AppColors.mint),
                  const SizedBox(width: 10),
                  Text('Say Hello',
                      style: TextStyle(
                          color: AppColors.mint,
                          fontSize: widget.isMobile ? 15 : 17,
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

class _FooterLink extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final String tooltip;
  const _FooterLink({required this.icon, required this.url, required this.tooltip});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 400),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: IconButton(
          onPressed: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
          icon: FaIcon(widget.icon, size: 17),
          color: _hover ? AppColors.gold : AppColors.slate,
        ),
      ),
    );
  }
}
