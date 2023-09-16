import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tropico/Pages/Alk.dart';
import 'package:tropico/Pages/Gazirana.dart';
import 'package:tropico/Pages/Pivo.dart';
import 'package:tropico/Pages/Negazirana.dart';
import 'package:tropico/Pages/Topla.dart';

import '../firebase_options.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});
  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initFirebase(); // Initialize Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/pozadina.jpg',
              fit: BoxFit.cover,
              alignment: const Alignment(0.1, 0.5),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(
                0.7,
              ), // Adjust the opacity (0.5 for semi-transparent)
            ),
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 180,
                      height: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Caffe & Lounge Tropico',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 30.0,
                        child: Divider(
                          color: Colors.white,
                          thickness: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: Text(
                        '"Neki slogan ovdje"',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 0, right: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 110, // height of button
                      width: 280,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              32), // Make the container round
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0, // Set the border width to 1
                          ),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/toplapica.png'), // Add the background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                  0.3), // Add the dimming color and opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets
                                .zero, // Remove padding to fill the button with the text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  32), // Add button border radius
                            ), // Set the text color
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Topla(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Topla pića',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 110, // height of button
                      width: 280,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              32), // Make the container round
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0, // Set the border width to 1
                          ),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/bezalk.jpg'), // Add the background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                  0.3), // Add the dimming color and opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets
                                .zero, // Remove padding to fill the button with the text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  32), // Add button border radius
                            ), // Set the text color
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GaziranaPica(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Gazirana pića',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 110, // height of button
                      width: 280,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              32), // Make the container round
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0, // Set the border width to 1
                          ),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/prir.jpeg'), // Add the background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                  0.3), // Add the dimming color and opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets
                                .zero, // Remove padding to fill the button with the text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  32), // Add button border radius
                            ), // Set the text color
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NegaziranaPica(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Negazirana pica',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 110, // height of button
                      width: 280,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              32), // Make the container round
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0, // Set the border width to 1
                          ),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/alk.jpg'), // Add the background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                  0.3), // Add the dimming color and opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets
                                .zero, // Remove padding to fill the button with the text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  32), // Add button border radius
                            ), // Set the text color
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AlkoholnaPica(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Žestoka pića',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 110, // height of button
                      width: 280,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              32), // Make the container round
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0, // Set the border width to 1
                          ),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/pivo.jpg'), // Add the background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                  0.3), // Add the dimming color and opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets
                                .zero, // Remove padding to fill the button with the text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  32), // Add button border radius
                            ), // Set the text color
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Pivo(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Pivo',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
