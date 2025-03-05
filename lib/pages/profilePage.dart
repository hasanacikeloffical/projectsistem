import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectsistem/loginPage.dart';
import 'package:projectsistem/pages/homePage.dart';

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
        backgroundColor: Colors.purple.shade100,
        body: Center(child: CircularProgressIndicator()), // Yüklenme animasyonu
      );
    }

    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Center(child: Text("Profil",
        style: TextStyle(color: Colors.white),)),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:20),
            
           
            // Text(
            //   user.displayName ?? "İsimsiz Kullanıcı",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            Center(
              child: Text(
                user.email ?? "E-posta bulunamadı",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            // Text(
            //   "UID: ${user.uid}",
            //   style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            // ),
            // SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
              ),
              icon: Icon(Icons.logout),
              label: Text("Çıkış Yap", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 500,),
             Align(
              alignment: Alignment.bottomLeft, // Sol alt tarafa sabitle
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomePage()),
                  ); // Geri gitme işlevi
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade300,
                ),
                child: Center(
                  child: Text(
                    'Geri Git',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
