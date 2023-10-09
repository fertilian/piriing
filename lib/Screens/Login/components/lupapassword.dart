import 'package:flutter/material.dart';
import 'package:piriing/Screens/Login/components/verifikasi.dart';

void main() {
  runApp(LupaPassword());
}

class LupaPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lupa Password'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lupa Password',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Silakan masukkan alamat email Anda yang terdaftar di akun kami. Kami akan mengirimkan tautan reset password ke email Anda.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'example@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Mengarahkan ke halaman VerifikasiPasswordPage saat tombol ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifikasiPasswordPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Kirim Tautan Reset Password',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
