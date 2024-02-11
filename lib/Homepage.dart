import 'package:flutter/material.dart';
import 'package:movieapp/bottom_navbar.dart';
import 'package:movieapp/home_screen.dart';
import 'package:movieapp/tes.dart';
import 'package:movieapp/tes2.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen3(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}