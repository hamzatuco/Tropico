import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(Pivo());
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
  Stream<QuerySnapshot>? _pivoStream;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase and then fetch data
    initializeFirebase().then((_) {
      setState(() {
        _pivoStream = fetchPivoStream();
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
      appBar: AppBar(
        title: const Text("Pivo at Tropico"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _pivoStream,
        builder: (context, cafeSnapshot) {
          if (cafeSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (cafeSnapshot.hasError) {
            return Text("Error: ${cafeSnapshot.error}");
          }
          if (cafeSnapshot.data == null || cafeSnapshot.data!.docs.isEmpty) {
            return const Text("Cafe 'Tropico' not found.");
          }

          final cafeDoc = cafeSnapshot.data!.docs.first;

          return StreamBuilder<QuerySnapshot>(
            stream: cafeDoc.reference
                .collection("artikli")
                .where("Kategorija", isEqualTo: "Pivo")
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
              // Build your UI using the data from snapshot.data!.docs
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final drink = snapshot.data!.docs[index];
                  final drinkName = drink["Naziv"];
                  final drinkPrice = drink["Cijena"];
                  return ListTile(
                    title: Text(drinkName ?? "N/A"),
                    subtitle: Text(drinkPrice ?? "N/A KM"),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
