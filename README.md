# Malak Ezat — Portfolio 💜

Personal portfolio for **Malak Ezat Adly** — Flutter Developer & UI/UX Designer.
Built with **Flutter Web**, featuring mobile apps, full web experiences, and Figma designs.

## ✨ What's inside

- **Sticky glass navbar** with smooth scroll to every section (+ mobile menu)
- **Hero** with typewriter animation, gradient branding & quick actions
- **About** — intro + tech stack chips
- **My Design** — Figma UI/UX case studies (Flash, Bar, ToneWave)
- **My Projects** — 8 projects in a responsive grid:
  - 🌐 **Bar Web App** — cakes & bakery store with a custom cake designer → [Live](https://barwebapp-50930.web.app/home)
  - 🌐 **Bar Dashboard** — full admin panel (products, coupons, discounts, customization orders) → [Live](https://bardashboard-e3321.web.app/#/customization-orders)
  - 🌐 **Wedding Invitation** — private invitation with photo gallery & RSVP system → [Live](https://weddingtest-2000.web.app/)
  - 📱 SaveKnee, E-Commerce, Weather, SuperNatural, ToDo (GitHub + YouTube demos)
- **Skills** with animated gradient level bars
- **Contact** with WhatsApp CTA and footer links

## 🪶 Lightweight build (v2.0)

| | Before | After |
|---|---|---|
| Assets size | ~7.1 MB | **~1.3 MB (−82%)** |
| Splash delay | ~5s forced wait | **none — instant load** |
| Dependencies | 15 packages (mostly unused) | **3** |
| Unused Firebase init & broken NFC script | yes | removed |

- Compressed `me.jpg` 2.7MB→102KB, `logo.png` 2MB→228KB, removed unused `dart.png` (1.4MB)
- Removed: firebase_core/auth/storage, google_fonts, animated_text_kit (custom 60-line typewriter instead), flutter_animate, auto_size_text, responsive_framework, visibility_detector, flutter_svg, js
- Icon font tree-shaken (1.6MB → 8KB)
- Cheap radial-gradient glows instead of expensive blur filters, `RepaintBoundary` on sections

## 🚀 Run & Deploy

```bash
flutter pub get
flutter run -d chrome          # develop
flutter build web --release    # build → build/web
firebase deploy --only hosting # deploy (project already configured)
```

> Requires Flutter ≥ 3.47 (stable). `font_awesome_flutter` was upgraded to v11 to match the latest stable toolchain.

## 📁 Structure

```
lib/
├── main.dart                  # app entry (no splash — instant)
├── Utils/                     # colors.dart (Aurora theme), constants.dart
├── Widgets/                   # nav_bar, section_shell (glass cards), typewriter_text
└── Sections/Screens/          # hero, about, design, projects, skills, contact
```

---

Made with 💙 by [Malak Ezat](https://github.com/Malak987) · [LinkedIn](https://linkedin.com/in/malak-ezat-b25777199) · [Figma](https://figma.com/@malakezat) · [Behance](https://behance.net/malakezat1)
