import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:piriing/Screens/Login/components/login_form.dart';
import 'package:piriing/Screens/dashboard/faq.dart';
import 'package:piriing/Screens/dashboard/form_imt.dart';
import 'package:piriing/Screens/kalori/kalori.dart';
import 'package:piriing/Screens/kalori/kaloriharian.dart';
import 'package:piriing/Screens/notifikasi/notifikasi.dart';
import 'package:piriing/Screens/tambahdarah/inputdarah.dart';
import 'package:piriing/Screens/tambahdarah/kalenderTab.dart';
import 'package:piriing/components/bottom_nav.dart';
import 'package:piriing/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:marquee/marquee.dart';
import 'package:piriing/Screens/profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String Nama = '';
  String Email = '';

  String TB = '';
  String BB = '';
  String Id = '';
  String umur = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');

    if (userDataString != null) {
      final userData = UserData.fromJson(json.decode(userDataString));
      print(userData.nama);

      setState(() {
        Nama = userData.nama;
        Email = userData.email;
        TB = userData.tinggiBadan;
        BB = userData.beratBadan;
        Id = userData.idUser.toString();
        umur = userData.umur;
      });
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.remove('user_data');

    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        child: LoginForm(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selected: 0),
      appBar: AppBar(
        toolbarHeight: 20,
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        'Hi, ' + Nama + Id,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Notifikasi(),
                            ),
                          );
                        },
                        child: Transform.scale(
                          scale: 1.5,
                          child: Icon(
                            Icons.notifications,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 25,
                  ),
                  child: Container(
                    height: 120,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FormIMT(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Umur',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                umur + ' Tahun',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tinggi\nBadan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                TB + 'cm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Berat\nBadan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                BB + 'kg',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'IMT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                '18.7',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 20,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 132, 165, 192)),
            child: Marquee(
              text:
                  'Jaga Kesehatan Anda Dengan Menjaga Pola Makan Dan Olah Raga Yang Cukup',
              style: TextStyle(fontSize: 16),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 300,
              velocity: 30,
              pauseAfterRound: Duration(seconds: 1),
              showFadingOnlyWhenScrolling: false,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
              startPadding: 10,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            child: ListView.builder(
              itemExtent: 250,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                List<List<Color>> gradients = [
                  [Colors.blue, Colors.white],
                  [Colors.green, Colors.white],
                  [Colors.red, Colors.white],
                  [Colors.orange, Colors.white],
                  [Colors.purple, Colors.white],
                ];

                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: gradients[index],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                        Container(
                          child: Text(
                            'Deskripsi \nGambar $index',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/shusi.webp',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
              padding: (EdgeInsets.only(left: 40)),
              child: Text(
                'Informasi Gizi Kesehatan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Container(
            height: 280,
            child: Column(
              children: [
                buildCard('Deskripsi Card 0', 130),
                SizedBox(
                  height: 15,
                ),
                buildCard('Deskripsi Card 1', 130),
                SizedBox(
                  height: 15,
                ),
                buildCard('Deskripsi Card 2', 130),
                // Tambahkan card lainnya di sini sesuai kebutuhan
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: (EdgeInsets.only(left: 40)),
              child: Text(
                'Pusat Informasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Container(
            height: 100,
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FAQPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/shusi.webp'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Center(
                              child: Text(
                            'Memiliki Pertanyaa Seputar \n Isi Piringku?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                  // Card kedua (Salin dan sesuaikan elemen di atas untuk card selanjutnya)
                ), // Card ketiga (Salin dan sesuaikan elemen di atas untuk card selanjutnya)
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TambahDarahKal(),
                      ));
                },
                child: Text("b")),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputDarah(),
                      ));
                },
                child: Text("b")),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String description, int calories) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/shusi.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('irisan susi mantap')
                ],
              ),
            ),
            SizedBox(width: 30),
            Column(
              children: [
                Center(child: Text(' 130 \nkalori')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
