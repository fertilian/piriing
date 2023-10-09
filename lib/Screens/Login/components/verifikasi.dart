import 'package:flutter/material.dart';

class VerifikasiPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Password'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan kata sandi Anda untuk verifikasi',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true, // Menyembunyikan kata sandi
              decoration: InputDecoration(
                labelText: 'Password Baru',
                hintText: 'Masukkan Password Baru',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true, // Menyembunyikan kata sandi
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                hintText: 'Konfirmasi Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk verifikasi kata sandi di sini
                // Anda dapat memeriksa apakah kata sandi yang dimasukkan sesuai
                // dengan yang seharusnya atau tidak.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 40.0),
              ),
              child: Text(
                'Verifikasi',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
