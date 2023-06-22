import 'package:calendar_app_remake/main.dart';
import 'package:calendar_app_remake/view/home/home_page.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _navigateToHomePage();
    });
  }

  _navigateToHomePage() async {
    // 2秒待つ
    await Future.delayed(const Duration(seconds: 2));
    // HomePageへ遷移
    Navigator.pushReplacement(
      navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ロゴやローディング画面などを表示
    return const Scaffold(
      body: Center(
        child: Text('Launch画面'),
      ),
    );
  }
}
