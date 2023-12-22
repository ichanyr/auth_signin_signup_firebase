import 'package:auth_signin_signup_firebase/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldEmailWidget extends StatefulWidget {
  const TextFieldEmailWidget({super.key, required this.controller});
  // variabel controller dengan tipe data TextEditingController yang bersifat final untuk mengontrol data inputan pengguna
  final TextEditingController controller;

  @override
  State<TextFieldEmailWidget> createState() => _TextFieldEmailWidgetState();
}

class _TextFieldEmailWidgetState extends State<TextFieldEmailWidget> {
  @override
  Widget build(BuildContext context) {
    // variabel loadAuth untuk mengakses data yang ada pada objek AuthProvider dari context
    var loadAuth = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: widget.controller,
          // variabel autovalidateMode untuk mengatur kapan validasi form akan dilakukan
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            } else if (!value.trim().contains('@')) {
              return 'Please enter valid email';
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredEmail = value!;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter email',
          ),
        )
      ],
    );
  }
}
