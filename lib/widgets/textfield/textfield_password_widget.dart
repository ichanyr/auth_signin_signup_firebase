import 'package:auth_signin_signup_firebase/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  const TextFieldPasswordWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  // variabel obsecureText untuk mengatur apakah password akan ditampilkan atau tidak
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    // variabel loadAuth untuk mengakses data yang ada pada objek AuthProvider dari context
    var loadAuth = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obsecureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            } else if (value.trim().length < 6) {
              return 'Please enter valid password';
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredPassword = value!;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Enter password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye_rounded))),
        )
      ],
    );
  }
}
