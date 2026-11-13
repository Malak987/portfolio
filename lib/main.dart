import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Utils/colors.dart';
import 'Sections/Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Malak Ezat | Flutter Developer & UI/UX Designer',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.darkNavy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.dark,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      home: const HomeScreen(),
    );
  }
}
