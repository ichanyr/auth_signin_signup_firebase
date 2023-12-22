import 'package:auth_signin_signup_firebase/provider/auth_provider.dart';
import 'package:auth_signin_signup_firebase/screens/home_screen.dart';
import 'package:auth_signin_signup_firebase/widgets/textfield/textfield_email_widget.dart';
import 'package:auth_signin_signup_firebase/widgets/textfield/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProvider>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false digunakan untuk mengatur agar tampilan tidak berubah ketika keyboard muncul.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/download.jpg'),
                    fit: BoxFit.cover),
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loadAuth.isLogin ? 'Sign In' : 'Register',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.purple,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 3))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: loadAuth.form,
                        child: Column(
                          children: [
                            TextFieldEmailWidget(controller: emailController),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFieldPasswordWidget(
                                controller: passwordController),
                            SizedBox(height: 30),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    setState(() {});
                                    loadAuth.submitForm();
                                  },
                                  child: Text(
                                    loadAuth.isLogin ? 'Sign In' : 'Register',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loadAuth.isLogin ? 'Not registered yet?' : '',
                      style: TextStyle(fontSize: 16, color: Color(0xffFACBEA)),
                    ),
                    InkWell(
                        onTap: () {
                          loadAuth.isLogin = !loadAuth.isLogin;
                          // membangun kembali widget yang bergantung pada loadAuth.isLogin, sehingga tampilan akan diperbarui sesuai dengan perubahan tersebut.
                          setState(() {});
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                          // );
                        },
                        child: Text(
                          loadAuth.isLogin
                              ? ' Creat an account'
                              : "I already have account",
                          style: TextStyle(
                              color: Color(0xffD988B9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                )
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => SignUpScreen()),
                //     );
                //   },
                //   child: RichText(
                //       text: TextSpan(children: [
                //     TextSpan(
                //         text: 'Not registered yet?',
                //         style: TextStyle(color: Colors.black)),
                //     TextSpan(
                //         text: ' Create an account ',
                //         style: TextStyle(color: Colors.blue)),
                //   ])),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
