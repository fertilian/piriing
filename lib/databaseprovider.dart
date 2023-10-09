// DatabaseProvider.dart
import 'package:flutter/material.dart';
import 'package:piriing/model/tambahdarah.dart';

class DatabaseProvider extends ChangeNotifier {
  List<TambahDarah> _database = [];

  List<TambahDarah> get database => _database;

  void fetchDataFromDatabase() {
    // Simulated data retrieval from the database (replace with your actual code)
    _database = [
      TambahDarah(
        id_user: '36',
        tanggal: '2023-10-01',
        status: 'belum',
      ),
      // Add more records as needed
    ];

    notifyListeners();
  }
}
