import 'package:flutter/material.dart';
import 'package:fingerprint_reconization/fingerprint_reconization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final plugin = FingerprintReconization();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fingerprint Demo')),
        body: Center(
          child: ElevatedButton(
            child: Text("Authentifier"),
            onPressed: () async {
              try {
                final result = await plugin.authenticate();
                print('Résultat : $result');
              } catch (e) {
                print('Erreur : $e');
              }
            },
          ),
        ),
      ),
    );
  }
}
