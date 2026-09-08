import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:protofolio/Sections/Screens/home_screen.dart';
import 'package:protofolio/Utils/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startApp();
  }

  Future<void> startApp() async {
    // ⬅️ هنا تحط أي حاجة بتتعمل في البداية
    // Firebase init / API calls / cache loading
    Future<void> startApp() async {
  try {
    // 1️⃣ Firebase
     await Firebase.initializeApp();

    // 2️⃣ Shared Preferences
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString("token");

    // 3️⃣ API preload (اختياري)
    // await ProductsRepository().getAllProducts();

    // 4️⃣ fake loading (لو مفيش حاجات حقيقية)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 5️⃣ Navigation
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  } catch (e) {
    debugPrint("Splash Error: $e");

    // fallback لو حصل مشكلة
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(color:AppColors.green ,padding: EdgeInsets.all(20),)
          ),

          // 🔥 Loading bar تحت
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade800,
                  color: AppColors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}