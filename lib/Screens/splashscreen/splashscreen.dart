import 'package:flutter/material.dart';
import 'package:piriing/Screens/Login/components/login_form.dart';
// import 'package:piriing/Screens/Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  Future<void> _loadSplash() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashScreen(),
    );
  }

  Widget _buildSplashScreen() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 250, 154, 0),
            Color.fromARGB(255, 246, 80, 20),
            Color.fromARGB(255, 235, 38, 16),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_2.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 5),
            Text(
              'ISI PIRINGKU',
              style: TextStyle(
                //fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24, // Tambahkan ukuran teks jika perlu
              ),
            ),
          ],
        ),
      ),
    );
  }
}
