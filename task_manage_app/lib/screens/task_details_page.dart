import 'package:flutter/material.dart';

import '../components/custom_text.dart';

class TaskDetailsPage extends StatelessWidget {
  final String title;
  final String description;

  const TaskDetailsPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        title: CustomText(
            text: 'Task Details',
            color: Colors.black,
            fsize: 25,
            fweight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: size.height * 0.8,
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
