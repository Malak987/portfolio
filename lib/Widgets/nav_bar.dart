import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/colors.dart';

class SectionLink {
  final String label;
  final GlobalKey key;
  const SectionLink(this.label, this.key);
}

class NavBar extends StatefulWidget {
  final List<SectionLink> links;
  final ScrollController scrollController;
  const NavBar({super.key, required this.links, required this.scrollController});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;
  bool _menuOpen = false;

  static const _resume = 'https://flowcv.com/resume/w0sjf0chwn';

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final s = widget.scrollController.offset > 60;
    if (s != _scrolled && mounted) setState(() => _scrolled = s);
  }

  void _goTo(SectionLink link) {
    setState(() => _menuOpen = false);
    final ctx = link.key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: -0.06, // small top gap for the floating bar
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 860;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(top: _scrolled ? 8 : 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: compact ? 14 : 24),
              child: Material(
                color: Colors.transparent,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: _scrolled || _menuOpen
                        ? const Color(0xD90A0F20)
                        : Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: (_scrolled || _menuOpen)
                          ? Colors.white.withOpacity(0.10)
                          : Colors.white.withOpacity(0.05),
                    ),
                    boxShadow: _scrolled
                        ? [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 10))]
                        : const [],
                  ),
                  child: compact ? _compactRow() : _fullRow(),
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 220),
              sizeCurve: Curves.easeOut,
              crossFadeState: _menuOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: const SizedBox(width: double.infinity),
              secondChild: compact
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
                      child: Material(
                        color: const Color(0xF00A0F20),
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final link in widget.links)
                                InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: () => _goTo(link),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                    child: Text(link.label,
                                        style: const TextStyle(color: AppColors.slate, fontSize: 14, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brand() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ShaderMask(
        shaderCallback: (b) => AppColors.accentGradient.createShader(b),
        child: const Text('Malak.',
            style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
      ),
    );
  }

  Widget _fullRow() {
    return Row(
      children: [
        _brand(),
        const Spacer(),
        for (final link in widget.links)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _NavButton(label: link.label, onTap: () => _goTo(link)),
          ),
        const SizedBox(width: 8),
        _ResumeChip(onTap: () => launchUrl(Uri.parse(_resume), mode: LaunchMode.externalApplication)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _compactRow() {
    return Row(
      children: [
        _brand(),
        const Spacer(),
        _ResumeChip(onTap: () => launchUrl(Uri.parse(_resume), mode: LaunchMode.externalApplication)),
        const SizedBox(width: 6),
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => setState(() => _menuOpen = !_menuOpen),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
            child: Icon(_menuOpen ? Icons.close_rounded : Icons.menu_rounded,
                color: AppColors.lightSlate, size: 22),
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavButton({required this.label, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              color: _hover ? AppColors.gold : AppColors.slate,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ResumeChip extends StatelessWidget {
  final VoidCallback onTap;
  const _ResumeChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColors.accentGradient,
          borderRadius: BorderRadius.circular(999),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(FontAwesomeIcons.fileLines, size: 12, color: Colors.white),
                SizedBox(width: 7),
                Text('Resume',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
