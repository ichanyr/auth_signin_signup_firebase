import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// variabel untuk menginisialisasi Firebase Authentication
final _fireAuth = FirebaseAuth.instance;

class AuthProvider extends ChangeNotifier {
  // variabel untuk menyimpan data yang dimasukkan pengguna ke dalam form
  final form = GlobalKey<FormState>();
  //
  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';
  // method untuk memvalidasi data yang dimasukkan pengguna ke dalam form.
  void submitForm() async {
    // variabel untuk menyimpan hasil validasi form
    final isValid = form.currentState!.validate();
    // jika hasil validasi tidak sesuai, maka akan mengembalikan nilai false
    if (!isValid) {
      return;
    }
    // method yang digunakan jika hasil validasi sesuai, maka akan menyimpan data yang dimasukkan pengguna ke dalam form
    form.currentState!.save();

    try {
      if (isLogin) {
        // method untuk login
        final LoginCredential = await _fireAuth.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      } else {
        // method untuk register
        final RegisterCredential =
            await _fireAuth.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          print('Email already in use');
        }
      }
    } finally {
      notifyListeners();
    }

    print(enteredEmail);
    print(enteredPassword);
  }
}
