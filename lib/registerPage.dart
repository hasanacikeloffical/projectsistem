import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _registerPage createState() => _registerPage();
}

class _registerPage extends State<RegisterPage> {
  final FirebaseAuth _authModel = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      await _authModel.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt başarılı bir şekilde oluşturuldu!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; // height değişkenini tanımla
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.8,
                    image: AssetImage("assets/image/design.png"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                       
                      ),
                      child: Text(
                        'Üye Ol',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 340),
                    Align(
                      alignment: Alignment.bottomLeft, // Sol alt tarafa sabitle
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Geri gitme işlevi
                        },
                        style: TextButton.styleFrom(
                          
                          
                        ),
                        child: Center(
                          child: Text(
                            'Geri Git',
                            style: TextStyle(color: Colors.purple),
                          ),
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
  }
}
