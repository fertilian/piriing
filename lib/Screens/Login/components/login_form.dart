import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piriing/Screens/Login/components/lupapassword.dart';
import 'package:piriing/Screens/dashboard/dashboar.dart';

import 'package:piriing/components/constants.dart';
import 'package:piriing/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/already_have_an_account_acheck.dart';

import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String clientId = "PKL2023";
  String clientSecret = "PKLSERU";
  String tokenUrl = "https://isipiringku.esolusindo.com/api/Token/token";

  String accessToken = "";
  late UserData userData;
  bool _showPassword = false; // Deklarasi _showPassword
  String _usernameError = ""; // Deklarasi _usernameError
  String _passwordError = ""; // Deklarasi _passwordError

  Future<void> getToken() async {
    try {
      var response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> tokenData = jsonDecode(response.body);
        accessToken = tokenData['access_token'];
        print('Token Akses: $accessToken');
      } else {
        print('Gagal mendapatkan token: ${response.statusCode}');
      }
    } catch (e) {
      print('Gagal mendapatkan token: $e');
    }
  }

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    await getToken(); // Memanggil fungsi getToken untuk mendapatkan token OAuth2

    // Membuat request body
    final Map<String, String> data = {
      "username": username,
      "password": password,
    };

    // Mengirim permintaan HTTP POST ke API dengan menyertakan token
    final response = await http.post(
      Uri.parse('https://isipiringku.esolusindo.com/api/Login/Login'),
      headers: {
        'Authorization':
            'Bearer $accessToken', // Menyertakan token dalam header
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Simpan data pengguna ke SharedPreferences

      print(responseData);
      userData = UserData.fromJson(responseData['response']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', accessToken);
// Simpan data pengguna lainnya jika diperlukan
      prefs.setString('user_data', json.encode(userData.toJson()));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    } else {
      final responseData = json.decode(response.body);

      if (responseData['response'] != null) {
        final errorMessage = 'username atau password salah';
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        print('Gagal masuk: ${response.statusCode}');
        print('Pesan kesalahan: ${response.body}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Ambil token saat halaman login dimuat
    getToken();

    // Periksa apakah token akses sudah ada
    checkUserSession();
  }

  Future<void> checkUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAccessToken = prefs.getString('access_token');

    if (savedAccessToken != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
      // Token akses sudah ada, mungkin pengguna sudah masuk
      // Anda dapat memeriksa validitas token di sini
      // Misalnya, jika token kedaluwarsa, Anda dapat mengarahkan pengguna untuk logout
      // atau memperbarui token.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/resa.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_2.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Masukkan Username',
                        labelStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_usernameError.isNotEmpty) // Mengganti _usernameError
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _usernameError,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Masukkan Password',
                          labelStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          )),
                    ),
                  ),
                  if (_passwordError.isNotEmpty) // Mengganti _passwordError
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _passwordError,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigasi ke halaman LupaPassword ketika teks "Lupa Password" ditekan
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LupaPassword()),
                        );
                      },
                      child: Text(
                        'Lupa Password',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUpScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Tidak punya akun? Buat satu',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
