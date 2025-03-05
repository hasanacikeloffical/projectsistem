import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectsistem/loginPage.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    // Kullanıcı giriş yapmadıysa Login sayfasına yönlendir
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Yüklenme animasyonu
      );
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Profil"))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user.photoURL != null ? NetworkImage(user.photoURL!) : null,
              child:
                  user.photoURL == null ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 20),

            // Text(
            //   user.displayName ?? "İsimsiz Kullanıcı",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),

            Text(
              user.email ?? "E-posta bulunamadı",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),

            // Text(
            //   "UID: ${user.uid}",
            //   style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            // ),
            // SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: Icon(Icons.logout),
              label: Text("Çıkış Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
