import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piriing/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<EditProfile> {
  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harus diisi';
    }
    return null; // Data valid
  }

  XFile? _imageFile;
  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Id = '';

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');

    if (userDataString != null) {
      final userData = UserData.fromJson(json.decode(userDataString));
      print(userData.nama);

      setState(() {
        Id = userData.idUser.toString();
      });
    }
  }

  TextEditingController idUserController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController tinggiBadanController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController kabupatenController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController umurController = TextEditingController();

  String clientId = "PKL2023";
  String clientSecret = "PKLSERU";
  String tokenUrl = "https://isipiringku.esolusindo.com/api/Token/token";
  String accessToken = "";

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

  void registerUser() async {
    final apiUrl =
        'https://isipiringku.esolusindo.com/api/UpdateProfil/UpdateProfil';

    final Map<String, dynamic> data = {
      'id_user': Id,
      'username': usernameController.text,
      'jabatan': jabatanController.text,
      'nama': namaController.text,
      'tgl_lahir': tanggalLahirController.text,
      'tinggi_badan': tinggiBadanController.text,
      'alamat': alamatController.text,
      'kecamatan': kecamatanController.text,
      'kabupaten': kabupatenController.text,
      'provinsi': provinsiController.text,
      'jekel': jenisKelaminController.text,
      'no_telp': noTelpController.text,
      'email': emailController.text,
      'umur': umurController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Menggunakan token OAuth2
        },
      );

      if (response.statusCode == 200) {
        // Registrasi berhasil, lakukan sesuatu di sini
        print('Registrasi berhasil');
        print(response.body);
      } else {
        // Registrasi gagal, tampilkan pesan kesalahan atau lakukan sesuatu yang sesuai
        print('Registrasi gagal. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Terjadi kesalahan dalam proses registrasi
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 55, 0, 0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: 200,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFC327),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                      spreadRadius: 4,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('Update Profile',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 185, 0, 0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 680,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF7D23),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                      spreadRadius: 4,
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 85, 8, 0),
                                      child: TextFormField(
                                        controller: usernameController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                          hintText:
                                              'Masukkan Username Baru Disini',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFFC327),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                        ),
                                        validator: _validateNotEmpty,
                                        // validator: _model
                                        //     .textController1Validator
                                        //     .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 185, 8, 0),
                                      child: TextFormField(
                                        // controller: _model.textController2,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Berat Badan',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                          hintText:
                                              'Masukkan Berat Badan Disini',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFFC327),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                        ),
                                        validator: _validateNotEmpty,
                                        // validator: _model
                                        //     .textController2Validator
                                        //     .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 285, 8, 0),
                                      child: TextFormField(
                                        controller: tinggiBadanController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Tinggi Badan',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                          hintText:
                                              'Masukkan Tinggi Badan Disini',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFFC327),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                        ),
                                        validator: _validateNotEmpty,
                                        // validator: _model
                                        //     .textController3Validator
                                        //     .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 385, 8, 0),
                                      child: TextFormField(
                                        // controller: _model.textController3,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Tinggi Badan',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                          hintText:
                                              'Masukkan Tinggi Badan Baru Disini',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFFC327),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                        ),
                                        validator: _validateNotEmpty,
                                        // validator: _model
                                        //     .textController3Validator
                                        //     .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 485, 8, 0),
                                      child: TextFormField(
                                        // controller: _model.textController3,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Tinggi Badan',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                          hintText:
                                              'Masukkan Tinggi Badan Baru Disini',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFFC327),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                        ),
                                        validator: _validateNotEmpty,
                                        // validator: _model
                                        //     .textController3Validator
                                        //     .asValidator(context),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, -1.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 585, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(150, 45),
                                            primary: Color.fromARGB(
                                                255,
                                                255,
                                                206,
                                                58), // Atur warna latar belakang tombol
                                            onPrimary: Colors
                                                .white, // Atur warna teks tombol
                                            padding: EdgeInsets.all(
                                                16), // Atur padding tombol
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // Atur sudut tombol
                                            ),
                                            elevation: 5,
                                            textStyle: TextStyle(
                                              fontSize:
                                                  14, // Atur ukuran teks tombol
                                              fontWeight: FontWeight
                                                  .bold, // Atur ketebalan teks tombol
                                              fontFamily: 'Readex Pro',
                                            ),
                                          ),
                                          child: Text(
                                              'Submit'), // Teks yang akan ditampilkan pada tombol
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(150, 115, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              print("Tapped on circle image");
                              _getImageFromGallery();
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: _imageFile != null
                                  ? Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 40.0,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
