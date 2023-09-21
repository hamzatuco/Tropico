// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const Pivo());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Pivo extends StatefulWidget {
  const Pivo({super.key});

  @override
  _PivoState createState() => _PivoState();
}

class _PivoState extends State<Pivo> {
  Stream<QuerySnapshot>? _PivoStream;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase and then fetch data
    initializeFirebase().then((_) {
      setState(() {
        _PivoStream = fetchPivoStream();
      });
    });
  }

  Stream<QuerySnapshot> fetchPivoStream() {
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
            "assets/pozadine/pivo.jpeg", // Replace with the path to your background image
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
            stream: _PivoStream,
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
                    .where("Kategorija",
                        isEqualTo: "Pivo") // Adjust the category as needed
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Text("No Pivo found at Tropico.");
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
                              color: const Color.fromARGB(255, 220, 185, 14)
                                  .withOpacity(0.8), // Pastel coffee color
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
                                        10, // Add some space between the image and texts
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
                "Pivo", // Changed text here
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

                    "Najbolji izbor piva za istinske ljubitelje ukusa i kvaliteta.",
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
