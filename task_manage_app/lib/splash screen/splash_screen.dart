import 'package:flutter/material.dart';
import 'package:task_manage_app/screens/homepage.dart';

import '../components/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Center(
        child: CustomText(
            text: 'Task Manage App',
            color: Colors.black,
            fsize: 30,
            fweight: FontWeight.bold),
      ),
    );
  }
}
