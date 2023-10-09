import 'package:flutter/material.dart';
import 'package:piriing/Screens/dashboard/dashboar.dart';
import 'package:piriing/Screens/tambahdarah/inputdarah.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TambahDarahKal extends StatefulWidget {
  const TambahDarahKal({Key? key}) : super(key: key);

  @override
  State<TambahDarahKal> createState() => _TambahDarahKalState();
}

class _TambahDarahKalState extends State<TambahDarahKal> {
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  String selectedDateText = '';
  String schedule1 = '08:00 - 10:00';
  String schedule2 = '16:00 - 18:00';
  bool isSchedule1Selected = false;
  bool isSchedule2Selected = false;

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.orange,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Text(
                            'KALENDER TAMBAH DARAH',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add your other UI components here
                ],
              ),
            ),
          ),
          Container(
              //   height: 130,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/home.jpg'),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 64)),
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.height * 0.4,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [BoxShadow(blurRadius: 1)],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 0,
                              ),
                              child: Center(
                                child: Text(
                                  'Tambah Darah',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TableCalendar(
                            calendarFormat: _calendarFormat,
                            focusedDay: _focusedDay,
                            firstDay: DateTime(2000),
                            lastDay: DateTime(2101),
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDate, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDate = selectedDay;
                                selectedDateText =
                                    _dateFormat.format(selectedDay);
                                // Reset schedule selection when the date changes
                                isSchedule1Selected = false;
                                isSchedule2Selected = false;
                              });
                            },
                            onFormatChanged: (format) {
                              _onFormatChanged(format);
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 45),
                                primary: Color.fromARGB(
                                    255, 255, 48, 48), // Background color
                                onPrimary: Colors.white, // Text color
                                padding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InputDarah(),
                                  ),
                                );
                              },
                              child: Text('Selanjutnya'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
