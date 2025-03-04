import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectsistem/pages/homePage.dart'; // Ana sayfa (Bottom Nav Bar olan yer)
import 'package:projectsistem/loginPage.dart'; // Giriş sayfası

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlat
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Uygulama açıldığında kontrol sayfası
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUserLogin(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ), // Yükleniyor ekranı
          );
        } else {
          if (snapshot.data != null) {
            return HomePage(); // Kullanıcı giriş yapmışsa HomePage
          } else {
            return LoginPage(); // Giriş yapmamışsa LoginPage
          }
        }
      },
    );
  }

  Future<User?> _checkUserLogin() async {
    return FirebaseAuth
        .instance
        .currentUser; // Firebase'de giriş yapmış kullanıcıyı al
  }
}
