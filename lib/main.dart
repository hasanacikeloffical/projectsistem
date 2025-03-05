import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectsistem/pages/settingsPage.dart';
import 'package:provider/provider.dart';
import 'package:projectsistem/core/ThemeManager.dart';
import 'package:projectsistem/core/localemanager.dart';
import 'package:projectsistem/pages/homePage.dart';
import 'package:projectsistem/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase başlatma
  runApp(ManagerScreen());
}

class ManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => LocalManager()),
      ],
      child: Consumer2<ThemeManager, LocalManager>(
        builder: (context, themeManager, localManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Firebase Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeManager.themeMode,
            locale: localManager.currentLocale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // İngilizce
              Locale('tr'), // Türkçe
            ],
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance.authStateChanges(), // Kullanıcı durumunu dinle
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ); // Yükleniyor ekranı
        } else if (snapshot.hasData && snapshot.data != null) {
          return HomePage(); // Kullanıcı giriş yapmışsa HomePage
        } else {
          return LoginPage(); // Kullanıcı çıkış yapmışsa LoginPage
        }
      },
    );
  }
}
