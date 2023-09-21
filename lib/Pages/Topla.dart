// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const Topla());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Topla extends StatefulWidget {
  const Topla({super.key});

  @override
  _ToplaState createState() => _ToplaState();
}

class _ToplaState extends State<Topla> {
  Stream<QuerySnapshot>? _toplaPicaStream;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase and then fetch data
    initializeFirebase().then((_) {
      setState(() {
        _toplaPicaStream = fetchToplaPicaStream();
      });
    });
  }

  Stream<QuerySnapshot> fetchToplaPicaStream() {
    return FirebaseFirestore.instance
        .collection("kafici")
        .where("Lokal", isEqualTo: "Tropico")
        .limit(1)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            "assets/pozadine/topla.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Dimming Overlay
          Container(
            color: Colors.black.withOpacity(0.7), // 70% dimming
            width: double.infinity,
            height: double.infinity,
          ),
          // Content
          StreamBuilder<QuerySnapshot>(
            stream: _toplaPicaStream,
            builder: (context, cafeSnapshot) {
              if (cafeSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset(
                    'assets/kafa.json', // Replace with the correct path to your "kafa.json" asset
                    width: 300, // Adjust the width as needed
                    height: 300, // Adjust the height as needed
                  ),
                );
              }

              if (cafeSnapshot.hasError) {
                return Text("Error: ${cafeSnapshot.error}");
              }
              if (cafeSnapshot.data == null ||
                  cafeSnapshot.data!.docs.isEmpty) {
                return const Text("Cafe 'Tropico' not found.");
              }

              final cafeDoc = cafeSnapshot.data!.docs.first;

              return StreamBuilder<QuerySnapshot>(
                stream: cafeDoc.reference
                    .collection("artikli")
                    .where("Kategorija", isEqualTo: "Topla pica")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Text("No Topla pica found at Tropico.");
                  }

                  // Assuming your Firestore documents have an "imageUrl" field
                  final drinkDocs = snapshot.data?.docs;

                  return Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: ListView.builder(
                      itemCount: drinkDocs?.length,
                      itemBuilder: (context, index) {
                        final drink = drinkDocs?[index];
                        final drinkName = drink?["Naziv"];
                        final drinkPrice = drink?["Cijena"];
                        final imageUrl = drink?[
                            "imageUrl"]; // Replace with your image field name

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.white, // White border color
                                width: 2, // Adjust the border width as needed
                              ),
                              color: const Color(0xFFD2B48C)
                                  .withOpacity(.8), // Pastel coffee color
                            ),
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                              child: Row(
                                children: [
                                  if (imageUrl != null)
                                    Image.network(
                                      imageUrl, // Load the image using the URL
                                      width:
                                          60, // Adjust the image size as needed
                                      height: 60,
                                    ),
                                  const SizedBox(
                                    width:
                                        15, // Add some space between the image and texts
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            drinkName ?? "N/A",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const Spacer(), // Pushes the following text to the far right
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            drinkPrice + ' KM' ?? "N/A KM",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),

          // App Bar with Back Arrow
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "Topli napitci", // Changed text here
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600, // Changed font weight
                ),
              ),
            ),
          ),
          Positioned(
              top: kToolbarHeight + 10.0, // Adjust the top position as needed
              left: 0, // Remove the left property
              right: 0, // Center the text horizontally
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Center(
                  child: Text(
                    textAlign:
                        TextAlign.center, // Postavite textAlign na center

                    "Zamislite šalicu sreće, okrunjenu mirisom toplih pića. Ovo je recept za savršen dan! ☕️",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
