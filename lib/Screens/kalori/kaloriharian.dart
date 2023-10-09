import 'package:flutter/material.dart';
import 'package:piriing/Screens/kalori/tambahKalori.dart';

class KaloriHarian extends StatefulWidget {
  const KaloriHarian({super.key});

  @override
  State<KaloriHarian> createState() => _KaloriHarianState();
}

class _KaloriHarianState extends State<KaloriHarian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 250, 154, 0),
                  Color.fromARGB(255, 246, 80, 20),
                  Color.fromARGB(255, 235, 38, 16),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.orange,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Text(
                              'KALORI HARIAN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '04-06-2023',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Budget Kalori Harian\n1800 Kkal',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 229, 222, 156),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "1191 Kkal",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70, // Tinggi container
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Tambahkan kode navigasi ke halaman dashboard di sini
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TambahKalori(); // Ganti dengan halaman dashboard yang sesuai
                                }));
                              },
                              child: Card(
                                elevation: 15, // Tingkat elevasi card
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      bottom: 5,
                                      right: 10.0), // Padding untuk konten card
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Gambar dari asset
                                      Container(
                                        width: 60.0, // Lebar gambar
                                        height: 60.0, // Tinggi gambar
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/morning.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      Center(
                                        child: Text(
                                          'SARAPAN',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      Container(
                                        child: Icon(
                                          Icons.plus_one,
                                          color: Colors.orange,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 75, // Tinggi container
                        child: Column(
                          children: [
                            // Card pertama
                            Card(
                              elevation: 15, // Tingkat elevasi card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    bottom: 10), // Padding untuk konten card
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Gambar dari asset
                                    Container(
                                      width: 60.0, // Lebar gambar
                                      height: 60.0, // Tinggi gambar
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sun.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        'MAKAN SIANG',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    Container(
                                      child: Icon(
                                        Icons.plus_one,
                                        color: Colors.orange,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 75, // Tinggi container
                        child: Column(
                          children: [
                            // Card pertama
                            Card(
                              elevation: 15, // Tingkat elevasi card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    bottom: 10), // Padding untuk konten card
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Gambar dari asset
                                    Container(
                                      width: 60.0, // Lebar gambar
                                      height: 60.0, // Tinggi gambar
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/half-moon.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        'MAKAN MALAM',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    Container(
                                      child: Icon(
                                        Icons.plus_one,
                                        color: Colors.orange,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80, // Tinggi container
                        child: Column(
                          children: [
                            // Card pertama
                            Card(
                              elevation: 15, // Tingkat elevasi card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    bottom: 10), // Padding untuk konten card
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Gambar dari asset
                                    Container(
                                      width: 50.0, // Lebar gambar
                                      height: 50.0, // Tinggi gambar
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/fast-food.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        'CAMILAN',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    Container(
                                      child: Icon(
                                        Icons.plus_one,
                                        color: Colors.orange,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TambahKalori(),
                                  ));
                            },
                            child: Text('gass')),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ]),
      ),
    );
  }
}
