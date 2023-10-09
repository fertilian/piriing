import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piriing/Screens/kalori/grafikKalori.dart';
import 'package:http/http.dart' as http;

class TambahKalori extends StatefulWidget {
  const TambahKalori({super.key});

  @override
  State<TambahKalori> createState() => _TambahKaloriState();
}

class _TambahKaloriState extends State<TambahKalori> {
  List<Map<String, dynamic>> foodData = [];

  String clientId = "PKL2023";
  String clientSecret = "PKLSERU";
  String tokenUrl =
      "https://apem.esolusindo.com/API/Token/token"; // Ganti dengan URL token endpoint Anda

  String accessToken = "";

  Future<void> getToken() async {
    try {
      // Buat permintaan untuk mendapatkan token menggunakan client_credentials
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
        // Handle error, misalnya, menampilkan pesan kesalahan
        print('Gagal mendapatkan token: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception, misalnya, menampilkan pesan kesalahan
      print('Gagal mendapatkan token: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://isipiringku.esolusindo.com/api/Makanan/makanan'),
      headers: {
        'Authorization':
            'Bearer $accessToken', // Use the access token obtained from getToken()
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['response'];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getToken().then((_) {
      fetchData().then((data) {
        setState(() {
          foodData = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH KALORI'),
        backgroundColor: Color.fromARGB(255, 250, 154, 0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Makan Apa Hari Ini?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: "Cari makanan",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: const Text(
                    "Nama Makanan",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text('Hasil Ditemukan:'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodData.length,
              itemBuilder: (context, index) {
                final foodItem = foodData[index];
                return Card(
                  child: ListTile(
                    title: Text(foodItem['bahan_makanan']),
                    subtitle: Text('Energi: ${foodItem['energi']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
